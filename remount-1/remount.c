/*
 * File: remount.c
 * Implements: remount of root filesystem as read-only or writable
 *
 * Copyright: Jens Låås, 2009
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

#include <sys/mount.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

void put(int fd, const char *s)
{
  write(fd, s, strlen(s));
}

int main(int argc, char **argv)
{
	int op=0;
	unsigned long mountflags = MS_REMOUNT;
	
	if(argc < 2) {
		put(1, "remount (r|w)\n Remounts root filesystem read-only or read-write\n");
		exit(0);
	}
	
	op = *argv[1];
	if(!strchr("rw", op)) {
		put(2, "remount: Specify 'r' or 'w' as remount operation.\n");
		exit(1);
	}
	
	put(1, "Remounting the system disk:  ");
	if(op == 'r') {
		mountflags |= MS_RDONLY;
		put(1, "read-only\n");
	} else {
		put(1, "writeable\n");
	}
	
	if(mount("rootfs", "/", "*", mountflags, NULL)) {
		put(2, "remount: remount failed.\n");
		exit(1);
	}
	
	sync();
	exit(0);
}
