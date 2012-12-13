/*
 * File: remount.c
 * Implements: remount of root filesystem as read-only or writable
 *
 * Copyright: Jens Låås, 2009, 2010
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

/*

mount("tmpfs", "/mnt/usb", 0x8056570, MS_MGC_VAL|MS_RDONLY|MS_REMOUNT, NULL) = 0

      #include <sys/mount.h>

       int mount(const char *source, const char *target,
                 const char *filesystemtype, unsigned long mountflags,
                 const void *data);

       mount()  attaches the file system specified by source (which is often a
       device name, but can also be a directory name or a dummy) to the direc-
       tory specified by target.

      Values  for  the  filesystemtype  argument  supported by the kernel are
       listed in  /proc/filesystems  (like  "minix",  "ext2",  "ext3",  "jfs",
       "xfs",  "reiserfs",  "msdos",  "proc", "nfs", "iso9660" etc.).

*/

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mount.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#ifndef MS_RELATIME
#define MS_RELATIME  (1 << 21)
#endif

void put(int fd, const char *s)
{
  write(fd, s, strlen(s));
}

int optcmp(const char *p, const char *name)
{
	if(strncmp(p, name, strlen(name)))
		return 0;
	if(*(p+strlen(name)) == ',')
		goto found;
	if(*(p+strlen(name)) == ' ') {
	found:
		return 1;
	}
	return 0;
}

unsigned long mountflags(const char *p)
{
	unsigned long flags = 0;
	
	if(!p) return -1;

	while(*p) {
		while(*p && *p == ' ') p++;
		if(optcmp(p, "ro")) flags |= MS_RDONLY;
		if(optcmp(p, "relatime")) flags |= MS_RELATIME;
		if(optcmp(p, "noatime")) flags |= MS_NOATIME;
		if(optcmp(p, "sync")) flags |= MS_SYNCHRONOUS;
		if(optcmp(p, "mand")) flags |= MS_MANDLOCK;
		while(*p) {
			if(*p == ' ') break;
			if(*p == ',') break;
			p++;
		}
		if(!*p) break;
		if(*p == ' ') break;
		p++;
	}
	
	return flags;
}

int romount(unsigned long *flags, const char *path)
{
	int fd, rc, found=0;
	char buf[2048], *p, *pp, *fp, mpath[256];
	
	fd = open("/proc/mounts", O_RDONLY);
	if(fd == -1) {
		put(2, "Failed to open /proc/mounts\n");
		return -1;
	}
	rc = read(fd, buf, sizeof(buf)-1);
	if( rc <= 0) {
		close(fd);
		return -1;
	}
	buf[rc] = 0;
	
	p = buf;
	while(1) {
		pp = strchr(p, ' ');
		if(pp) {
			pp++;
			fp = strchr(pp, ' ');
			if(fp) {
				strncpy(mpath, pp, fp-pp);
				mpath[fp-pp] = 0;
				fp++;
				if(!strcmp(mpath, path)) {
					if(strncmp(fp, "rootfs", 6)) {
						*flags = mountflags(strchr(fp, ' '));
						return (*flags)&MS_RDONLY?1:0;
					}
					else {
						if(!found)
							*flags = mountflags(strchr(fp, ' '));
						found = 1;
					}
				}
			}
		}
		p = strchr(p, '\n');
		if(!p) break;
		p++;
	}
	if(found) return (*flags)&MS_RDONLY?1:0;
	return -1;
}

int main(int argc, char **argv)
{
	int op=0;
	unsigned long mountflags = MS_REMOUNT;
	unsigned long flags = 0;
	int romountflag = 0;
	
	if(argc < 2) {
		put(1, "remount (r|w)\n Remounts root filesystem read-only or read-write\n");
		exit(0);
	}
	
	op = *argv[1];
	if(!strchr("rw", op)) {
		put(2, "remount: Specify 'r' or 'w' as remount operation.\n");
		exit(2);
	}
	
	romountflag = romount(&flags, "/");
	if(romountflag == -1) flags = 0;
	
	put(1, "Remounting the system disk:  ");
	if(op == 'r') {
		flags |= MS_RDONLY;
		put(1, "read-only\n");
	} else {
		flags ^= MS_RDONLY;
		put(1, "writeable\n");
	}
	
	if(mount("rootfs", "/", "*", mountflags|flags, NULL)) {
		put(2, "remount: remount failed.\n");
		exit(2);
	}
	
	sync();

	/* If the mount flag is unchanged this is a "failure" */
	if( romount(&flags, "/") == romountflag )
		if(romountflag != -1) 
			exit(1);

	exit(0);
}
