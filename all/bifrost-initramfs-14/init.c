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
	int async;
	int install;
	int autoresize;
	unsigned int rootdelay;
	char *rootdev;
	char *rootfstype;
	char *rootfslabel;
	char *init;
} cmdline;

struct {
	unsigned long mountflags;
} conf;

struct tar_header {
	char name[100];
	char mode[8];
	char uid[8];
	char gid[8];
	char size[12];
	char mtime[12];
	char chksum[8];
	char typeflag;
	char linkname[100];
	char magic[6];
	char version[2];
	char uname[32];
	char gname[32];
	char devmajor[8];
	char devminor[8];
	char prefix[155];
	char filler[12];
};

static int data(int fd, int len, int ofd)
{
	char buf[1024];
	ssize_t n;

	while(len) {
		n = read(fd, buf, len > 1024 ? 1024 : len);
		if(n < 1) return 0;
		if(ofd >= 0) write(ofd, buf, n);
		len -= n;
	}
	return 0;
}


static int tar_extract(int fd)
{
	char filename[256];
	char buf[1024];
	struct tar_header *th;
	ssize_t siz, nulsiz;
	int mode;
	
	while(read(fd,buf,512)==512) {
		filename[0] = 0;
		th=(struct tar_header*)buf;
		if(th->name[0] == 0) break;
		if (th->prefix[0]) strcat(filename, th->prefix);
		strcat(filename, th->name);
		siz=strtoull(th->size,0,8);
		mode=strtoul(th->mode,0,8);
		if(siz) {
			int ofd;
			if(fstdout) fprintf(fstdout, "INSTALL: extracting '%s' [%c] %zd bytes\n", filename, th->typeflag, siz);
			ofd = open(th->name, O_CREAT|O_TRUNC|O_WRONLY, mode);
			if(ofd == -1) {
				if(fstdout) fprintf(fstdout, "INSTALL: failed to open '%s'\n", filename);
			}
			data(fd, siz, ofd);
			if(ofd != -1) {
				close(ofd);
			}
			nulsiz = ((siz+512) & ~511) - siz;
			data(fd, nulsiz, -1);
		} else {
			if(th->name[strlen(th->name)-1] == '/') {
				mkdir(filename, mode|S_IFDIR);
			}
		}
		if(th->typeflag == 2) {
			if(fstdout) fprintf(fstdout, "INSTALL: creating link '%s' -> '%s'\n", th->linkname, filename);
			if(symlink(th->linkname,filename)) {
				if(fstdout) fprintf(fstdout, "INSTALL: symlink '%s' failed\n", filename);
			}
		}
	}
	return 0;
}


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
			/* put console fd at fd number 10 */
			dup2(fd, 10);
			close(fd);
			fd=10;
			
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

static void strgetarg(char **arg)
{
	char *p;
	p = *arg;
	if(*p == '"') {
		p++;
		*arg = p;
		p = strchr(p, '"');
		if(p) *p = 0;
		return;
	}
	
	p = strchr(*arg, ' ');
	if(p) *p = 0;
	p = strchr(*arg, '\n');
	if(p) *p = 0;
	return;
}

char *initstr(const char *haystack, const char *needle)
{
	char *p;
	const char *h;
	h = haystack;
	
	while(h && *h) {
		p = strstr(h, needle);
		if(!p) return NULL;
		
		if( (p == haystack) || (*(p-1) == ' ') ) {
			if(needle[strlen(needle)-1] == '=') return p;
			if(*(p+strlen(needle)) == ' ') return p;
			if(*(p+strlen(needle)) == 0) return p;
			if(*(p+strlen(needle)) == '=') return p;
			return p;
		}
		h = p+1;
	}
	return NULL;
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
			p = initstr(buf, "rootdelay=");
			if(p) {
				cmdline.rootdelay = strtoul(p+10, NULL, 0);
			}
			p = initstr(buf, "root=");
			if(p) {
				cmdline.rootdev = strdup(p+5);
				strgetarg(&cmdline.rootdev);
			}
			p = initstr(buf, "rootfstype=");
			if(p) {
				cmdline.rootfstype = strdup(p+11);
				strgetarg(&cmdline.rootfstype);
			}
			p = initstr(buf, "init=");
			if(p) {
				cmdline.init = strdup(p+5);
				strgetarg(&cmdline.init);
			}
			p = initstr(buf, "rootfslabel=");
			if(p) {
				cmdline.rootfslabel = strdup(p+12);
				strgetarg(&cmdline.rootfslabel);
			}
			p = initstr(buf, "usbreset");
			if(p) {
				cmdline.usbreset = 1;
			}
			p = initstr(buf, "async");
			if(p) {
				cmdline.async = 1;
			}
			p = initstr(buf, "noresize");
			if(p) {
				cmdline.autoresize = 0;
			}
			p = initstr(buf, "install");
			if(p) {
				cmdline.install = 1;
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

int chk_cfg_file(int *remounted, char *fn)
{
	struct stat statb;
	ssize_t n;
	int srcfd, dstfd;
	char src[512], dst[512], buf[1024];
	
	sprintf(src, "/etc/config.preconf/%s.default", fn);
	sprintf(dst, "/etc/%s", fn);
	
	if(stat(dst, &statb)) {
		if(stat(src, &statb)) {
			return -1;
		}
		if (mount("rootfs", "/", NULL, MS_REMOUNT|MS_NOATIME|conf.mountflags, NULL) < 0) {
			if(fstdout)
				fprintf(fstdout, "INIT: failed to remount rootfs as read-write\n");
			sleep(1);
			return -1;
		}
		*remounted = 1;
		if( (srcfd = open(src, O_RDONLY)) == -1 ) {
			if(fstdout)
				fprintf(fstdout, "INIT: failed to open %s for reading\n", src);
			sleep(1);
			return -1;
		}
		if( (dstfd = open(dst, O_WRONLY|O_CREAT|O_TRUNC)) == -1 ) {
			if(fstdout)
				fprintf(fstdout, "INIT: failed to open %s for writing\n", dst);
			sleep(1);
			close(srcfd);
			return -1;
		}
		while(1) {
		retry:
			n = read(srcfd, buf, sizeof(buf));
			if( n == -1 ) {
				if(errno == EAGAIN)
					goto retry;
			}
			if(n == 0) break;
			write(dstfd, buf, n);
		}
		close(srcfd);
		close(dstfd);
		sync();
	}
	return 0;
}

int main(int argc, char **argv, char **envp)
{
	int fd_stdin=-1, fd_stdout=-1;
	pid_t pid;
	int retries = 0;
	int rootmounted = 0;
	char *rootdev = NULL;
	char *rootfstype = "unknown";
	char *rootfslabel = ROOTFSLABEL;
	char *initprg = "/sbin/init";

	conf.mountflags = MS_SYNCHRONOUS;
	
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
	cmdline.autoresize = 1;
	cmdline_parse();
	
	if(cmdline.init) {
		initprg = cmdline.init;
	}
	
	if(cmdline.async) {
		conf.mountflags ^= MS_SYNCHRONOUS;
	}
	
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
		if(cmdline.rootfslabel) {
			if(strncmp(cmdline.rootfslabel, "LABEL=", 6)) {
				rootfslabel = malloc(strlen("LABEL=") + strlen(cmdline.rootfslabel) + 1);
				strcpy(rootfslabel, "LABEL=");
				strcat(rootfslabel, cmdline.rootfslabel);
			} else {
				rootfslabel = cmdline.rootfslabel;
			}
		}
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
	} else {
		if(fstdout) fprintf(fstdout, "INIT: using rootdev %s\n", rootdev);
	}
	sleep(1);

	/* if filesystem is of the ext family */
	if((!cmdline.rootfstype) || (!strncmp(cmdline.rootfstype, "ext", 3))) {
		int status = 0;
		int fsckok = 0;
		/* e2fsck -y rootdev */
		/* fork + exec("/e2fsck", "/e2fsck"-y", rootdev) */
		if((pid=fork())==0) {
			execl("/e2fsck", "/e2fsck", "-y", rootdev, NULL);
			exit(0);
		}
		if(pid != -1) {
			wait(&status);
			if(WIFEXITED(status)) {
				fprintf(fstdout, "INIT: e2fsck exited normally with exit code: %d\n", WEXITSTATUS(status));
				if(WEXITSTATUS(status)==0) fsckok=1;
			} else {
				fprintf(fstdout, "INIT: e2fsck exited abnormally\n");
			}
		}
		if(fsckok) {
			if(cmdline.autoresize) {
				sync();
				if((pid=fork())==0) {
					execl("/resize2fs", "/resize2fs", "-f", rootdev, NULL);
					exit(0);
				}
				if(pid != -1) wait(NULL);
				sync();
			}
		}
	}
	
	/* unlink /e2sck and /resize2fs to save some memory */
	if(unlink("/e2fsck")) {
		fprintf(fstdout, "INIT: unlink(\"/e2fsck\") failed: %s\n", strerror(errno));
	}
	if(unlink("/resize2fs")) {
		fprintf(fstdout, "INIT: unlink(\"/resize2fs\") failed: %s\n", strerror(errno));
	}
	
	if(cmdline.rootfstype) {
		/* mount /rootfs, try fstype supplied on kernel commandline */
		if(mount(rootdev, "/rootfs", cmdline.rootfstype, MS_NOATIME|MS_RDONLY|conf.mountflags, "")) {
			if(fstdout) fprintf(fstdout, "INIT: failed to mount (%s) %s: %s\n",
						 cmdline.rootfstype, rootdev, strerror(errno));
		} else {
			rootmounted = 1;
			rootfstype = cmdline.rootfstype;
		}
	}
	if(!rootmounted) {
		/* mount /rootfs, try ext2 */
		if(mount(rootdev, "/rootfs", "ext2", MS_NOATIME|MS_RDONLY|conf.mountflags, "")) {
			if(fstdout) fprintf(fstdout, "INIT: failed to mount (ext2) %s: %s\n", rootdev, strerror(errno));
			goto forever;
		}
		rootfstype = "ext2";
	}
	
	if(fstdout) fprintf(fstdout, "INIT: (%s) %s mounted.\n", rootfstype, rootdev);
	sleep(1);

	if(cmdline.install) {
		if(fstdout) {
			fprintf(fstdout, "INIT: INSTALL INVOKED!\nINSTALL: PROCEEDING IN 5 SECONDS!\n");
			sleep(5);
		}
		
		/* unpack install archive in initramfs root */
		{
			int fd;
			fd = open("/rootfs/install.tar", O_RDONLY);
			if(fd == -1) {
				if(fstdout) fprintf(fstdout, "INSTALL: failed to open '/rootfs/install.tar'\n");
			} else {
				if(fstdout) fprintf(fstdout, "INSTALL: '/rootfs/install.tar' opened ok\n");
				tar_extract(fd);
				close(fd);
			}
		}

		/* Be nice and prepare stdin and stdout for the install program */
		fd_stdin = open("/dev/console", O_RDONLY|O_NOCTTY);
		if(fd_stdin == -1) {
			if(fstdout)
				fprintf(fstdout, "INSTALL: open(\"/dev/console\", O_RDONLY) failed: %s\n", strerror(errno));
		} else {
			if(fd_stdin != 0) {
				dup2(fd_stdin, 0);
				close(fd_stdin);
			}
		}
		fd_stdout = open("/dev/console", O_WRONLY|O_NOCTTY);
		if(fd_stdout == -1) {
			if(fstdout)
				fprintf(fstdout, "INSTALL: open(\"/dev/console\", O_WRONLY) failed: %s\n", strerror(errno));
		} else { 
			if(fd_stdout != 1) {
				dup2(fd_stdout, 1);
				dup2(fd_stdout, 2);
				close(fd_stdout);
			}
		}

		/* exec "/install" */
		{
			char *iv[2];
		iv[0] = "/install";
		iv[1] = NULL;
		if(fstdout)
			fprintf(fstdout, "INSTALL: exec(\"/install\")\n");
		execve(iv[0], iv, envp);
		if(fstdout)
			fprintf(fstdout, "INSTALL: exec(\"/install\") failed\n");
		sleep(10);
		}
	}
	
	if (mount("/dev", "/rootfs/dev", NULL, MS_MOVE, NULL) < 0) {
		if(fstdout)
			fprintf(fstdout, "INIT: failed to mount moving /dev to /rootfs/dev\n");
		sleep(1);
	}
	if (mount("/proc", "/rootfs/proc", NULL, MS_MOVE, NULL) < 0) {
		if(fstdout)
			fprintf(fstdout, "INIT: failed to mount moving /proc to /rootfs/proc\n");
		sleep(1);
	}
	if(chdir("/rootfs")) {
		if(fstdout)
			fprintf(fstdout, "INIT: chdir(\"/rootfs\") failed: %s\n", strerror(errno));
		goto forever;
	}
	if (mount("/rootfs", "/", NULL, MS_MOVE, NULL) < 0) {
		if(fstdout)
			fprintf(fstdout, "INIT: failed to mount moving /rootfs to /\n");
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

	/* check if we need to copy default versions of some config files */
	{
		int remounted=0;
		chk_cfg_file(&remounted, "ssh/ssh_config");
		chk_cfg_file(&remounted, "ssh/sshd_config");
		chk_cfg_file(&remounted, "inetd.conf");
		chk_cfg_file(&remounted, "inittab");
		chk_cfg_file(&remounted, "login.defs");
		chk_cfg_file(&remounted, "limits");
		chk_cfg_file(&remounted, "login.access");
		if(remounted)
			if (mount("rootfs", "/", NULL, MS_REMOUNT|MS_NOATIME|MS_RDONLY|conf.mountflags, NULL) < 0) {
				if(fstdout)
					fprintf(fstdout, "INIT: failed to remount rootfs as read-only\n");
				sleep(1);
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
		fprintf(fstdout, "INIT: now execing \"%s\"\n", initprg);
	sleep(1);

	if(fstdout) {
		fclose(fstdout);
		fstdout = NULL;
	}
	argv[0] = initprg;
	execve(initprg, argv, envp);
	
	open_console();

	if(fstdout) {
		fprintf(fstdout, "INIT: execve(\"%s\") failed: %s\n", initprg, strerror(errno));
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


