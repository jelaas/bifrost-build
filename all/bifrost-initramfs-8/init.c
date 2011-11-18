#include <blkid/blkid.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <ctype.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <fcntl.h>
/* #include <sys/mount.h> */
#include <linux/fs.h>
#include <sys/ioctl.h>
#include <linux/usbdevice_fs.h>

int mount(const char *source, const char *target,
	  const char *filesystemtype, unsigned long mountflags,
	  const void *data);

#ifndef MAXSYMLINKS
# define MAXSYMLINKS 256
#endif

#define ROOTFSLABEL "LABEL=bifrost"

/* int pivot_root(const char *new_root, const char *put_old); */
#define pivot_root(new_root,put_old) syscall(SYS_pivot_root,new_root,put_old)

static blkid_cache blcache;

FILE *fstdout = NULL;

struct {
	int usbreset;
	unsigned int rootdelay;
	char *rootdev;
	char *rootfstype;
	char *rootfslabel;
} cmdline;

static char *canonicalize_dm_name(const char *ptname)
{
	FILE	*f;
	size_t	sz;
	char	path[256], name[256], *res = NULL;

	snprintf(path, sizeof(path), "/sys/block/%s/dm/name", ptname);
	if (!(f = fopen(path, "r")))
		return NULL;

	/* read "<name>\n" from sysfs */
	if (fgets(name, sizeof(name), f) && (sz = strlen(name)) > 1) {
		name[sz - 1] = '\0';
		snprintf(path, sizeof(path), "/dev/mapper/%s", name);
		res = strdup(path);
	}
	fclose(f);
	return res;
}

static char *myrealpath(const char *path, char *resolved_path, int maxreslth) {
	int readlinks = 0;
	char *npath;
	char link_path[PATH_MAX+1];
	int n;
	char *buf = NULL;

	npath = resolved_path;

	/* If it's a relative pathname use getcwd for starters. */
	if (*path != '/') {
		if (!getcwd(npath, maxreslth-2))
			return NULL;
		npath += strlen(npath);
		if (npath[-1] != '/')
			*npath++ = '/';
	} else {
		*npath++ = '/';
		path++;
	}

	/* Expand each slash-separated pathname component. */
	while (*path != '\0') {
		/* Ignore stray "/" */
		if (*path == '/') {
			path++;
			continue;
		}
		if (*path == '.' && (path[1] == '\0' || path[1] == '/')) {
			/* Ignore "." */
			path++;
			continue;
		}
		if (*path == '.' && path[1] == '.' &&
		    (path[2] == '\0' || path[2] == '/')) {
			/* Backup for ".." */
			path += 2;
			while (npath > resolved_path+1 &&
			       (--npath)[-1] != '/')
				;
			continue;
		}
		/* Safely copy the next pathname component. */
		while (*path != '\0' && *path != '/') {
			if (npath-resolved_path > maxreslth-2) {
				errno = ENAMETOOLONG;
				goto err;
			}
			*npath++ = *path++;
		}

		/* Protect against infinite loops. */
		if (readlinks++ > MAXSYMLINKS) {
			errno = ELOOP;
			goto err;
		}

		/* See if last pathname component is a symlink. */
		*npath = '\0';
		n = readlink(resolved_path, link_path, PATH_MAX);
		if (n < 0) {
			/* EINVAL means the file exists but isn't a symlink. */
			if (errno != EINVAL)
				goto err;
		} else {
			int m;
			char *newbuf;

			/* Note: readlink doesn't add the null byte. */
			link_path[n] = '\0';
			if (*link_path == '/')
				/* Start over for an absolute symlink. */
				npath = resolved_path;
			else
				/* Otherwise back up over this component. */
				while (*(--npath) != '/')
					;

			/* Insert symlink contents into path. */
			m = strlen(path);
			newbuf = malloc(m + n + 1);
			if (!newbuf)
				goto err;
			memcpy(newbuf, link_path, n);
			memcpy(newbuf + n, path, m + 1);
			free(buf);
			path = buf = newbuf;
		}
		*npath++ = '/';
	}
	/* Delete trailing slash but don't whomp a lone slash. */
	if (npath != resolved_path+1 && npath[-1] == '/')
		npath--;
	/* Make sure it's null terminated. */
	*npath = '\0';

	free(buf);
	return resolved_path;

 err:
	free(buf);
	return NULL;
}


static char *canonicalize_path(const char *path)
{
	char canonical[PATH_MAX+2];
	char *p;

	if (path == NULL)
		return NULL;

	if (!myrealpath(path, canonical, PATH_MAX+1))
		return strdup(path);


	p = strrchr(canonical, '/');
	if (p && strncmp(p, "/dm-", 4) == 0 && isdigit(*(p + 4))) {
		p = canonicalize_dm_name(p+1);
		if (p)
			return p;
	}

	return strdup(canonical);
}

static void fsprobe_init(void)
{
	blcache = NULL;
}

static int fsprobe_parse_spec(const char *spec, char **name, char **value)
{
	*name = NULL;
	*value = NULL;

	if (strchr(spec, '='))
		return blkid_parse_tag_string(spec, name, value);

	return 0;
}

static char *fsprobe_get_devname_by_label(const char *label)
{
	return blkid_evaluate_tag("LABEL", label, &blcache);
}

static char *fsprobe_get_devname_by_spec(const char *spec)
{
	char *name, *value;

	if (!spec)
		return NULL;
	if (fsprobe_parse_spec(spec, &name, &value) != 0)
		return NULL;				/* parse error */
	if (name) {
		char *nspec = NULL;

		if (!strcmp(name,"LABEL"))
			nspec = fsprobe_get_devname_by_label(value);

		free(name);
		free(value);
		return nspec;
	}

	return canonicalize_path(spec);
}

static int mkmountpoint(const char *p) {
	if(mkdir(p, 0777)) {
		if(errno != EEXIST) {
			if(fstdout) {
				fprintf(fstdout, "INIT: cannot create mountpoint %s: %s\n", p, strerror(errno));
				fprintf(fstdout, "INIT: waiting 10 seconds ..\n");
				sleep(5);
				sleep(5);
			}
			return errno;
		}
	}
	return 0;
}

static int open_console()
{
	int fd;
	
	if(!fstdout) {
		fd = open("/dev/console", O_WRONLY|O_NOCTTY|O_NDELAY);
		if(fd >=0 ) {
#define INITMSG "INIT: console opened\n"
			write(fd, INITMSG, strlen(INITMSG));
			sleep(2);
			fstdout = fdopen(fd, "w");
			return 0;
		}
		return -1;
	}
	return 0;
}

/*
 * kernel commandline can be read from /proc/cmdline
 */
static int cmdline_parse()
{
	char *p, buf[512];
	int fd;
	ssize_t n;
	
	fd = open("/proc/cmdline", O_RDONLY);
	if(fd >= 0) {
		n = read(fd, buf, sizeof(buf)-1);
		if(n > 0) {
			buf[n] = 0;
			p = strstr(buf, "rootdelay=");
			if(p) {
				cmdline.rootdelay = strtoul(p+10, NULL, 0);
			}
			p = strstr(buf, "root=");
			if(p) {
				cmdline.rootdev = strdup(p+5);
				p = strchr(cmdline.rootdev, ' ');
				if(p) *p = 0;
			}
			p = strstr(buf, "rootfstype=");
			if(p) {
				cmdline.rootfstype = strdup(p+11);
				p = strchr(cmdline.rootfstype, ' ');
				if(p) *p = 0;
			}
			p = strstr(buf, "rootfslabel=");
			if(p) {
				cmdline.rootfslabel = strdup(p+12);
				p = strchr(cmdline.rootfslabel, ' ');
				if(p) *p = 0;
			}
			p = strstr(buf, "usbreset");
			if(p) {
				cmdline.usbreset = 1;
			}
		}
		close(fd);
	}
	return 0;
}

static int usbresetdev(const char *filename)
{
	int fd, rc;
	
	fd = open(filename, O_WRONLY);
	if (fd == -1) {
		if(fstdout) fprintf(fstdout, "INIT: [USB] could not open %s\n", filename);
		return 1;
	}
	
	rc = ioctl(fd, USBDEVFS_RESET, 0);
	if (rc == -1) {
		if(errno != EISDIR) if(fstdout) fprintf(fstdout, "INIT: [USB] %s reset failed: %s\n", filename, strerror(errno));
		close(fd);
		return 1;
	}
	if(fstdout) fprintf(fstdout, "INIT: [USB] %s reset OK\n", filename);

	close(fd);
	return 0;
}

static int usbreset()
{
	char fn[256];
	struct stat statb;
	int bus, dev;

	if(fstdout) fprintf(fstdout, "INIT: [USB] performing USB reset on all ports\n");
	
	for(bus=1;bus<10;bus++) {
		for(dev=1;dev<10;dev++) {
			sprintf(fn, "/dev/bus/usb/%03d/%03d", bus, dev);
			if(stat(fn, &statb)==0)
				usbresetdev(fn);
		}
	}
	return 0;
}

static int listdevices()
{
	char fn[256];
        struct stat statb;
        int dev, part;

	fprintf(fstdout, "INIT: [DEV] devices in dev:\n");

        for(dev='a';dev<'f';dev++) {
                sprintf(fn, "/dev/sd%c", dev);
                if(stat(fn, &statb)==0) {
			fprintf(fstdout, "INIT: [DEV] %s: ", fn);
   		        for(part='1';part<'5';part++) {
     	 			sprintf(fn, "/dev/sd%c%c", dev, part);
      	 	                if(stat(fn, &statb)==0)
         	                       fprintf(fstdout, "%s ", fn);
          		}
			fprintf(fstdout, "\n");
		}
        }
	return 0;
}

int main(int argc, char **argv, char **envp)
{
	int fd_stdin=-1, fd_stdout=-1;
	pid_t pid;
	int guess = 0;
	int retries = 0;
	int rootmounted = 0;
	char *rootdev = NULL;
	char *rootfstype = "unknown";
	char *rootfslabel = ROOTFSLABEL;
	
	open_console();

	/* create mountpoints /dev and /proc /rootfs */
	
	mkmountpoint("/dev");
	mkmountpoint("/proc");
	mkmountpoint("/rootfs");

	open_console();
	
	/* make sure /dev is mounted */
	if(mount("devtmpfs", "/dev",
		 "devtmpfs", 0,
		 "")) {
		if(fstdout) {
			if(fstdout) {
				fprintf(fstdout, "INIT: could not mount devtmpfs on /dev: %s\n", strerror(errno));
				fprintf(fstdout, "INIT: waiting 10 seconds ..\n");
				sleep(5);
				sleep(5);
			}
		}	
	}

	open_console();
	
	/* mount /proc */
	if(mount("proc", "/proc",
		 "proc", 0,
		 "")) {
		if(fstdout) {
			fprintf(fstdout, "INIT: could not mount proc on /proc: %s\n", strerror(errno));
			fprintf(fstdout, "INIT: waiting 10 seconds ..\n");
			sleep(5);
			sleep(5);
		}	
	}
	
	/* parse kernel commandline options */
	cmdline_parse();

	if(cmdline.usbreset) {
		usbreset();
		sleep(1);
	}

	if(cmdline.rootdelay > 0) {
		if(fstdout) fprintf(fstdout, "INIT: rootdelay, waiting %d seconds\n", cmdline.rootdelay);
		sleep(cmdline.rootdelay);
	}
	
	if(cmdline.rootdev) {
		struct stat statb;
		if(fstdout) fprintf(fstdout, "INIT: rootdev %s given on commandline\n", cmdline.rootdev);
		rootdev = cmdline.rootdev;
		if(stat(rootdev, &statb)) {
			if(fstdout) fprintf(fstdout, "INIT: rootdev %s not found!\n", rootdev);
			rootdev = NULL;
		}
	}
	
	if(!rootdev) {
		if(cmdline.rootfslabel) rootfslabel = cmdline.rootfslabel;
		if(fstdout) fprintf(fstdout, "INIT: probing for rootdev labeled '%s'\n", rootfslabel);
		fsprobe_init();
		while( (rootdev = fsprobe_get_devname_by_spec(rootfslabel)) == NULL ) {
			retries++;
			if(retries == 15) usbreset();
			if(retries > 25) break;
			if(fstdout) fprintf(fstdout, "INIT: waiting for rootdevice to be available\n");
			sleep(2);
			fsprobe_init();
		}
	}
	
	if(!rootdev) {
		if(fstdout) {
			fprintf(fstdout, "INIT: could not find rootdevice\n");
			listdevices();
			fprintf(fstdout, "INIT: waiting 10 seconds ..\n");
			sleep(5);
			sleep(5);
			fprintf(fstdout, "INIT: guessing that rootdev is /dev/sda1\n\n");
		}
		rootdev="/dev/sda1";
		guess = 1;
	} else {
		if(fstdout) fprintf(fstdout, "INIT: using rootdev %s\n", rootdev);
	}
	sleep(1);

	/* e2fsck -y rootdev */
	/* fork + exec("/e2fsck", "/e2fsck"-y", rootdev) */
	if((pid=fork())==0) {
		execl("/e2fsck", "/e2fsck", "-y", rootdev, NULL);
		exit(0);
	}
	if(pid != -1) wait(NULL);
	
	/* unlink /e2sck to save some memory */
	if(unlink("/e2fsck")) {
		fprintf(fstdout, "INIT: unlink(\"/e2fsck\") failed: %s\n", strerror(errno));
	}
	
	if(cmdline.rootfstype) {
		/* mount /rootfs, try fstype supplied on kernel commandline */
		if(mount(rootdev, "/rootfs", cmdline.rootfstype, MS_NOATIME|MS_RDONLY, "")) {
			if(fstdout) fprintf(fstdout, "INIT: failed to mount (%s) %s: %s\n",
						 cmdline.rootfstype, rootdev, strerror(errno));
		} else {
			rootmounted = 1;
			rootfstype = cmdline.rootfstype;
		}
	}
	if(!rootmounted) {
		/* mount /rootfs, try ext2 */
		if(mount(rootdev, "/rootfs", "ext2", MS_NOATIME|MS_RDONLY, "")) {
			if(fstdout) fprintf(fstdout, "INIT: failed to mount (ext2) %s: %s\n", rootdev, strerror(errno));
			goto forever;
		}
		rootfstype = "ext2";
	}
	
	if(fstdout) fprintf(fstdout, "INIT: (%s) %s mounted.\n", rootfstype, rootdev);
	sleep(1);

	if (mount("/dev", "/rootfs/dev", NULL, MS_MOVE, NULL) < 0) {
		if(fstdout)
			fprintf(fstdout, "INIT: failed to mount moving /dev to /rootfs/dev");
		sleep(1);
	}
	if (mount("/proc", "/rootfs/proc", NULL, MS_MOVE, NULL) < 0) {
		if(fstdout)
			fprintf(fstdout, "INIT: failed to mount moving /proc to /rootfs/proc");
		sleep(1);
	}
	if(chdir("/rootfs")) {
		if(fstdout)
			fprintf(fstdout, "INIT: chdir(\"/rootfs\") failed: %s\n", strerror(errno));
		goto forever;
	}
	if (mount("/rootfs", "/", NULL, MS_MOVE, NULL) < 0) {
		if(fstdout)
			fprintf(fstdout, "INIT: failed to mount moving /rootfs to /");
		goto forever;
	}

        /*
	  Now, the init process may still access the old root via its
	  executable, shared libraries, standard input/output/error, and its
	  current root directory. All these references are dropped by the
	  following command:
	  
	  # exec chroot . /sbin/init <dev/console >dev/console 2>&1
	*/
	
	if(chroot(".")) {
		if(fstdout) {
			fprintf(fstdout, "INIT: chroot(\".\") failed: %s\n", strerror(errno));
			sleep(5);
			sleep(5);
		}
	}
	
	fd_stdin = open("/dev/console", O_RDONLY|O_NOCTTY);
	if(fd_stdin == -1) {
		if(fstdout)
			fprintf(fstdout, "INIT: open(\"/dev/console\", O_RDONLY) failed: %s\n", strerror(errno));
	} else {
		if(fd_stdin != 0) {
			dup2(fd_stdin, 0);
			close(fd_stdin);
		}
	}
	fd_stdout = open("/dev/console", O_WRONLY|O_NOCTTY);
	if(fd_stdout == -1) {
		if(fstdout)
			fprintf(fstdout, "INIT: open(\"/dev/console\", O_WRONLY) failed: %s\n", strerror(errno));
	} else { 
		if(fd_stdout != 1) {
			dup2(fd_stdout, 1);
			dup2(fd_stdout, 2);
			close(fd_stdout);
		}
	}
	
	if(fstdout)
		fprintf(fstdout, "INIT: now execing \"/sbin/init\"\n");
	sleep(1);

	if(fstdout) {
		fclose(fstdout);
		fstdout = NULL;
	}
	argv[0] = "/sbin/init";
	execve("/sbin/init", argv,
	       envp);
	
	open_console();

	if(fstdout) {
		fprintf(fstdout, "INIT: execve(\"/sbin/init\") failed: %s\n", strerror(errno));
	}
forever:
	if(fstdout) {
		fprintf(fstdout, "INIT: pid is %u\n", getpid());
		fprintf(fstdout, "INIT: boot cannot proceed from here.\n");
		fprintf(fstdout, "INIT: turn off the computer.\n");
	}
	while(1) sleep(1000);
	return 2;
}

/*
find . | cpio --quiet -H newc -o | gzip -9 -n > /boot/imagefile.img

 */

/*
  - When switching another root device, initrd would pivot_root and then
    umount the ramdisk.  But initramfs is rootfs: you can neither pivot_root
    rootfs, nor unmount it.  Instead delete everything out of rootfs to
    free up the space (find -xdev / -exec rm '{}' ';'), overmount rootfs
    with the new root (cd /newmount; mount --move . /; chroot .), attach
    stdin/stdout/stderr to the new /dev/console, and exec the new init.

    Since this is a remarkably persnickety process (and involves deleting
    commands before you can run them), the klibc package introduced a helper
    program (utils/run_init.c) to do all this for you.  Most other packages
    (such as busybox) have named this command "switch_root".
*/

/*

gcc -Wall -static -o init init.c -lblkid -luuid
*/


