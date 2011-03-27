/*
 * File: daemonize.c
 * Implements:
 *
 * Copyright: Jens Låås, 2009
 * Copyright license: According to GPL, see file COPYING in this directory.
 *
 */

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "daemonize.h"

void daemonize(void)
{
    pid_t pid, sid;
    int fd;

    /* already a daemon */
    if ( getppid() == 1 ) return;

    if((pid = fork()) < 0)
	    exit(-1);

    if (pid > 0) _exit(0);

    umask(0);

    if((sid = setsid()) < 0)
	    exit(-1);

    if ((chdir("/")) < 0)
	    exit(-1);

    if((fd = open("/dev/null", O_RDWR, 0)) >= 0) {
	    if(fd>2) {
		    dup2(fd, 0);
		    dup2(fd, 1);
		    dup2(fd, 2);
	    }
	    if(fd) close(fd);
    }
}

