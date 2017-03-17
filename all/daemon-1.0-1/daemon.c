/*
 * File: daemon.c
 * Implements: daemonizes a program
 *
 * Copyright: Jens Låås, 2016
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <pwd.h>
#include <grp.h>
#include <string.h>

int main(int argc, char **argv)
{
    pid_t pid, sid;
    int fd;

    if(argc < 4) exit(2);
    
    if((pid = fork()) < 0)
	    exit(-1);

    if (pid > 0) _exit(0);

    umask(022);

    if((sid = setsid()) < 0)
	    exit(-1);

    if((fd = open("/dev/null", O_RDWR, 0)) >= 0) {
	    if(fd>2) {
		    dup2(fd, 0);
		    dup2(fd, 1);
		    dup2(fd, 2);
	    }
	    if(fd) close(fd);
    }
    
    {
	    uid_t uid;
	    gid_t gid;
	    struct group *gent = 0;
	    struct passwd *pent = 0;
	    if(*argv[1] >= '0' && *argv[1] <= '9') {
		    uid = atoi(argv[1]);
	    } else {
		    while(1) {
			    pent = getpwent();
			    if(!pent) exit(2);
			    if(!strcmp(pent->pw_name, argv[1])) {
				    uid = pent->pw_uid;
				    break;
			    }
		    }
	    }
	    if(*argv[2] >= '0' && *argv[2] <= '9') {
		    gid = atoi(argv[2]);
	    } else {
		    while(1) {
			    gent = getgrent();
			    if(!gent) exit(2);
			    if(!strcmp(gent->gr_name, argv[2])) {
				    gid = gent->gr_gid;
				    break;
			    }
		    }
	    }
	    if(uid == -1) exit(2);
	    if(gid == -1) exit(2);
	    if(setgroups(0, &gid)) exit(2);
	    if(pent) initgroups(argv[1], gid);
	    if(setregid(gid, gid)) exit(2);
	    if(setreuid(uid, uid)) exit(2);
	    if(getuid() != uid) exit(2);
	    if(geteuid() != uid) exit(2);
	    if(getgid() != gid) exit(2);
	    if(getegid() != gid) exit(2);
    }
    
    argc -= 3;
    argv += 3;
    execv(argv[0], argv);
    exit(2);
}

