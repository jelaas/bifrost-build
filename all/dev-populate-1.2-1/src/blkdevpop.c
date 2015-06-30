/*
 * File: blkdevpop.c
 * Implements: automatic population of block devices as device nodes
 *
 * Copyright: Jens Låås, 2009
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#define _GNU_SOURCE
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <sys/poll.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <libgen.h>
#include <sys/mount.h>

#include <syscall.h>

#include <linux/types.h>
#include <linux/netlink.h>

#include "jelist.h"
#include "daemonize.h"
#include "jelopt.h"

struct dev {
	char *name, *subsystem;
	int major, minor, action;
};


struct {
	char *devdir;
	char *sysdir;
	int daemonize;
	int verbose, debug;
} conf;

void die(const char *s)
{
	if(conf.debug)
		write(2,s,strlen(s));
	exit(1);
}

/*

ACTION=add
DEVPATH=/block/sdb/sdb1
SUBSYSTEM=block
MAJOR=8
MINOR=17

*/


static inline char *strpfx(char *s, const char *pfx)
{
	if(!strncmp(s, pfx, strlen(pfx)))
		return s+strlen(pfx);
	return NULL;
}

int sysfs_mount()
{
	/* mount /sys in own namespace */
#ifdef __UCLIBC__
	if(syscall(SYS_unshare, CLONE_NEWNS))
		die("unshare NS\n");
#else
	if(unshare(CLONE_NEWNS))
		die("unshare NS\n");
#endif
	if(mount("sysfs", conf.sysdir, "sysfs", MS_NOATIME|MS_RDONLY, NULL))
		; /* /sys already mounted or mount-point does not exist.. */
	return 0;
}

int find_devs(struct jlhead *l, const char *base)
{
	DIR *d;
	char fn[512];
	struct dirent *ent;
	struct stat buf;
	
	d = opendir(base);
	if(!d) return 0;
	
	while((ent = readdir(d))) {
		if(ent->d_name[0] == '.')
			continue;
		
		sprintf(fn ,"%s/%s", base, ent->d_name);
		
		if(!strcmp(ent->d_name, "dev")) {
			jl_append(l, strdup(fn));
		} else {
			if(lstat(fn, &buf)==0) {
				if(S_ISDIR(buf.st_mode))
					find_devs(l, fn);
			}
		}
	}
	closedir(d);
	
	return 0;
}

int sysblock_scan()
{
	struct jlhead *devs;
	char *s, *p;
	char buf[16], fn[64];
	ssize_t n;
	int major, minor, fd;
	
	devs = jl_new();
	
	sprintf(fn, "%s/block", conf.sysdir);
	find_devs(devs, fn);
	
	jl_foreach(devs, s) {
		fd = open(s, O_RDONLY);
		if(fd != -1) {
			if((n=read(fd, buf, sizeof(buf)-1))>0) {
				buf[n] = 0;
				minor = 0;
				major = atoi(buf);
				p = strchr(buf, ':');
				if(p) 
					minor = atoi(p+1);
				
				s[strlen(s)-3] = 0;
				p=basename(s);
				
				sprintf(fn, "%s/%s", conf.devdir, p);
				if(conf.debug)
					printf("%s: major=%d minor=%d\n",
					       fn, major, minor);
				mknod(fn, 0640|S_IFBLK,
				      makedev(major, minor)); 
			}
			
			close(fd);
		}
	}
  
  return 0;
}

int dev_match(struct stat *statbuf, struct dev *dev)
{
	if(!S_ISBLK(statbuf->st_mode))
		return -1;
	if(dev->major == major(statbuf->st_dev))
		return -1;
	if(dev->minor == minor(statbuf->st_dev))
		return -1;
	return 0;
}

int main(int argc, char *argv[])
{
	struct sockaddr_nl nls;
	struct pollfd pfd;
	char *p, buf[1024];
	struct dev dev;
	int err=0;

	conf.devdir = "/dev";
	conf.sysdir = "/sys";

	if(jelopt(argv, 'h', "help", NULL, NULL)) {
		printf("blockdev-populate [-hd]\n"
		       " Version 1.2 By Jens Låås, UU 2009.\n"
		       " -d --daemonize\n"
		       " --debug\n"
		       " -v --verbose\n"
		       " --sysdir DIR\n"
		       " --devdir DIR\n");
		exit(0);
	}

	if(jelopt(argv, 0, "sysdir", &conf.sysdir, &err))
		;
	if(jelopt(argv, 0, "devdir", &conf.devdir, &err))
		;
	if(jelopt(argv, 'd', "daemonize", NULL, &err))
		conf.daemonize = 1;
	if(jelopt(argv, 'v', "verbose", NULL, &err))
		conf.verbose = 1;
	if(jelopt(argv, 0, "debug", NULL, &err))
		conf.verbose = conf.debug = 1;
	
	// mount local sysfs
	sysfs_mount();

	memset(&nls,0,sizeof(struct sockaddr_nl));
	nls.nl_family = AF_NETLINK;
	nls.nl_pid = getpid();
	nls.nl_groups = -1;

	pfd.events = POLLIN;
	pfd.fd = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_KOBJECT_UEVENT);
	if (pfd.fd==-1)
		die("Not root\n");
	
	if (bind(pfd.fd, (void *)&nls, sizeof(struct sockaddr_nl)))
		die("Bind failed\n");
	
	/* daemonize */
	if(conf.daemonize && !conf.debug)
		daemonize();
	
	/* Check/Create nodes in /sys/block */
	sysblock_scan();
	
	if(!conf.daemonize)
		exit(0);

	while (-1!=poll(&pfd, 1, -1)) {
		int i, len = recv(pfd.fd, buf, sizeof(buf)-1, MSG_DONTWAIT);
		if (len == -1) die("recv\n");
		buf[len] = 0;
		
		memset(&dev,0,sizeof(dev));
		
		//if(conf.debug) printf("########################\n");

		i = 0;
		while (i<len) {
		  //if(conf.debug) printf("MSG: %s\n", buf+i);
		
			if((p=strpfx(buf+i, "SUBSYSTEM=")))
				dev.subsystem = strdup(p);
			if((p=strpfx(buf+i, "MAJOR=")))
				dev.major = atoi(p);
			if((p=strpfx(buf+i, "MINOR=")))
				dev.minor = atoi(p);
			if((p=strpfx(buf+i, "DEVPATH=")))
				dev.name = basename(strdup(p));
			if(strpfx(buf+i, "ACTION=add"))
				dev.action = 1;
			
			i += strlen(buf+i)+1;
		}
		if(dev.action == 1) {
			if(!strcmp(dev.subsystem, "block"))
			{
				struct stat statbuf;
				int rc;
				
				if(conf.verbose)
					printf("Event %s device %s %d,%d\n", 
					       dev.subsystem,
					       dev.name,
					       dev.major,
					       dev.minor);
				
				sprintf(buf, "%s/%s", conf.devdir, dev.name);
				if((rc=stat(buf, &statbuf))||
				   !dev_match(&statbuf, &dev)) {
					if(rc==0) unlink(buf);
					if(conf.verbose)
						printf("Add %s device %s\n", 
						       dev.subsystem,
						       dev.name);
					if(mknod(buf, 0640|S_IFBLK,
						 makedev(dev.major,
							 dev.minor))) {
						if(conf.debug)
							printf("mknod(%s) failed\n", 
							       dev.name);
					}
						
				}
			}
		}
		
	}
	die("poll\n");
	
	return 0;
  }
