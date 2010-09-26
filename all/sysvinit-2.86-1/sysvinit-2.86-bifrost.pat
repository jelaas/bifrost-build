diff -ur sysvinit-2.86/man/halt.8 sysvinit-2.86-bifrost/man/halt.8
--- sysvinit-2.86/man/halt.8	2001-11-21 22:11:22.000000000 +0100
+++ sysvinit-2.86-bifrost/man/halt.8	2009-09-20 16:30:59.125711268 +0200
@@ -23,6 +23,7 @@
 .RB [ \-d ]
 .RB [ \-f ]
 .RB [ \-i ]
+.RB [ \-k ]
 .br
 .B /sbin/poweroff
 .RB [ \-n ]
@@ -65,6 +66,8 @@
 .IP \fB\-p\fP
 When halting the system, do a poweroff. This is the default when halt is
 called as \fBpoweroff\fP.
+.IP \fB\-k\fP
+Try to reboot using \fBkexec\fP, if kernel supports it.
 .\"}}}
 .\"{{{  Diagnostics
 .SH DIAGNOSTICS
diff -ur sysvinit-2.86/src/Makefile sysvinit-2.86-bifrost/src/Makefile
--- sysvinit-2.86/src/Makefile	2004-06-09 14:47:45.000000000 +0200
+++ sysvinit-2.86-bifrost/src/Makefile	2009-09-20 16:34:22.786711214 +0200
@@ -9,9 +9,9 @@
 #
 
 CC	= gcc
-CFLAGS	= -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE
-LDFLAGS	= -s
-STATIC	=
+CFLAGS	= -Wall -Os -fomit-frame-pointer -D_GNU_SOURCE -D__GLIBC__=2
+LDFLAGS	= -s -static
+STATIC	= -static
 
 # For some known distributions we do not build all programs, otherwise we do.
 BIN	=
diff -ur sysvinit-2.86/src/halt.c sysvinit-2.86-bifrost/src/halt.c
--- sysvinit-2.86/src/halt.c	2004-07-30 14:16:18.000000000 +0200
+++ sysvinit-2.86-bifrost/src/halt.c	2009-09-20 16:30:59.126711449 +0200
@@ -8,7 +8,7 @@
  *		execute an "shutdown -r". This is for compatibility with
  *		sysvinit 2.4.
  *
- * Usage:	halt [-n] [-w] [-d] [-f] [-h] [-i] [-p]
+ * Usage:	halt [-n] [-w] [-d] [-f] [-h] [-i] [-p] [-k]
  *		-n: don't sync before halting the system
  *		-w: only write a wtmp reboot record and exit.
  *		-d: don't write a wtmp record.
@@ -16,6 +16,7 @@
  *		-h: put harddisks in standby mode
  *		-i: shut down all network interfaces.
  *		-p: power down the system (if possible, otherwise halt).
+ *		-k: reboot the system using kexec.
  *
  *		Reboot and halt are both this program. Reboot
  *		is just a link to halt. Invoking the program
@@ -64,8 +65,10 @@
  */
 void usage(void)
 {
-	fprintf(stderr, "usage: %s [-n] [-w] [-d] [-f] [-h] [-i]%s\n",
-		progname, strcmp(progname, "halt") ? "" : " [-p]");
+	fprintf(stderr, "usage: %s [-n] [-w] [-d] [-f] [-h] [-i]%s%s\n",
+		progname,
+		strcmp(progname, "halt") ? "" : " [-p]",
+		strcmp(progname, "reboot") ? "" : " [-k]");
 	fprintf(stderr, "\t-n: don't sync before halting the system\n");
 	fprintf(stderr, "\t-w: only write a wtmp reboot record and exit.\n");
 	fprintf(stderr, "\t-d: don't write a wtmp record.\n");
@@ -74,6 +77,8 @@
 	fprintf(stderr, "\t-i: shut down all network interfaces.\n");
 	if (!strcmp(progname, "halt"))
 		fprintf(stderr, "\t-p: power down the system (if possible, otherwise halt).\n");
+	if (!strcmp(progname, "reboot"))
+		fprintf(stderr, "\t-k: reboot the system using kexec.\n");
 	exit(1);
 }
 
@@ -172,6 +177,7 @@
 	int do_ifdown = 0;
 	int do_hddown = 0;
 	int do_poweroff = 0;
+	int do_kexec = 0;
 	int c;
 	char *tm = NULL;
 
@@ -189,7 +195,7 @@
 	/*
 	 *	Get flags
 	 */
-	while((c = getopt(argc, argv, ":ihdfnpwt:")) != EOF) {
+	while((c = getopt(argc, argv, ":ihdfnpwkt:")) != EOF) {
 		switch(c) {
 			case 'n':
 				do_sync = 0;
@@ -213,6 +219,9 @@
 			case 'p':
 				do_poweroff = 1;
 				break;
+			case 'k':
+				do_kexec = 1;
+				break;
 			case 't':
 				tm = optarg;
 				break;
@@ -230,10 +239,24 @@
 	(void)chdir("/");
 
 	if (!do_hard && !do_nothing) {
+		c = get_runlevel();
+
+		/*
+		 *	 We can't reboot using kexec through this path.
+		 */
+		if (c != '6' && do_reboot && do_kexec) {
+			fprintf(stderr, "ERROR: using -k at this"
+				" runlevel requires also -f\n"
+				"  (You probably want instead to reboot"
+				" normally and let your reboot\n"
+				"   script, usually /etc/init.d/reboot,"
+				" specify -k)\n");
+			exit(1);
+		}
+		
 		/*
 		 *	See if we are in runlevel 0 or 6.
 		 */
-		c = get_runlevel();
 		if (c != '0' && c != '6')
 			do_shutdown(do_reboot ? "-r" : "-h", tm);
 	}
@@ -263,6 +286,16 @@
 	if (do_nothing) exit(0);
 
 	if (do_reboot) {
+		/*
+		 *	kexec or reboot
+		 */
+		if (do_kexec) {
+			init_reboot(BMAGIC_KEXEC);
+		}
+
+		/* 
+		 *	Fall through if failed
+		 */
 		init_reboot(BMAGIC_REBOOT);
 	} else {
 		/*
diff -ur sysvinit-2.86/src/init.c sysvinit-2.86-bifrost/src/init.c
--- sysvinit-2.86/src/init.c	2004-07-30 14:16:20.000000000 +0200
+++ sysvinit-2.86-bifrost/src/init.c	2009-10-07 10:54:29.826043560 +0200
@@ -21,6 +21,15 @@
  */
 
 #include <sys/types.h>
+
+#ifdef __linux__
+#include <linux/capability.h>
+#include <linux/unistd.h>
+#include <sys/syscall.h>
+#define capget(header, data) syscall(__NR_capget, header, data)
+#define capset(header, data) syscall(__NR_capset, header, data)
+#endif
+
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
@@ -466,7 +475,7 @@
 
 	if (maxproclen > 2) {
 		memset(argv0, 0, maxproclen);
-		strncpy(argv0, buf, maxproclen - 2);
+		strncpy(argv0, buf, maxproclen - 1);
 	}
 
 	return len;
@@ -949,6 +958,25 @@
   		sigprocmask(SIG_SETMASK, &omask, NULL);
 
 		/*
+		 * Update utmp/wtmp file prior to starting
+		 * any child.  This MUST be done right here in
+		 * the child process in order to prevent a race
+		 * condition that occurs when the child
+		 * process' time slice executes before the
+		 * parent (can and does happen in a uniprocessor
+		 * environment).  If the child is a getty and
+		 * the race condition happens, then init's utmp
+		 * update will happen AFTER the getty runs
+		 * and expects utmp to be updated already!
+		 *
+		 * Do NOT log if process field starts with '+'
+		 * FIXME: that's for compatibility with *very*
+		 * old getties - probably it can be taken out.
+		 */
+		if (ch->action == RESPAWN && ch->process[0] != '+')
+			write_utmp_wtmp("", ch->id, getpid(), INIT_PROCESS, "");
+
+		/*
 		 *	In sysinit, boot, bootwait or single user mode:
 		 *	for any wait-type subprocess we _force_ the console
 		 *	to be its controlling tty.
@@ -1088,15 +1116,7 @@
 		case ONDEMAND:
 		case RESPAWN:
   			ch->flags |= RUNNING;
-  			if (spawn(ch, &(ch->pid)) < 0) break;
-			/*
-			 *	Do NOT log if process field starts with '+'
-			 *	FIXME: that's for compatibility with *very*
-			 *	old getties - probably it can be taken out.
-			 */
-  			if (ch->process[0] != '+')
-				write_utmp_wtmp("", ch->id, ch->pid,
-					INIT_PROCESS, "");
+  			(void)spawn(ch, &(ch->pid));
   			break;
 	}
 }
@@ -1884,7 +1904,7 @@
 	 *	The existing init process execs a new init binary.
 	 */
 	env = init_buildenv(0);
-	execl(myname, myname, "--init", NULL, env);
+	execle(myname, myname, "--init", NULL, env);
 
 	/*
 	 *	We shouldn't be here, something failed. 
@@ -2348,6 +2368,11 @@
   pid_t			rc;
   int			f, st;
 
+#ifdef __linux__
+  struct __user_cap_header_struct head;
+  struct __user_cap_data_struct data[2];
+#endif
+
   if (!reload) {
   
 #if INITDEBUG
@@ -2438,6 +2463,26 @@
   		SETSIG(sa, SIGCHLD,  chld_handler, SA_RESTART);
   	}
 
+#ifdef __linux__
+	/*
+	 *	This seems like the right place to do this, just before
+	 *	we read /etc/inittab...
+	 */
+	memset(&head, 0, sizeof(head));
+	memset(&data, 0, sizeof(data));
+
+	head.pid     = 0;
+	head.version = _LINUX_CAPABILITY_VERSION_3;
+	
+	if (capget(&head, &data[0]) == 0) {
+	  /* Max out the inheritable capability set. */
+	  data[0].inheritable = data[0].effective;
+	  data[1].inheritable = data[1].effective;
+	  capset(&head, &data[0]);
+	}
+	
+#endif
+
   	/*
 	 *	Start normal boot procedure.
 	 */
diff -ur sysvinit-2.86/src/reboot.h sysvinit-2.86-bifrost/src/reboot.h
--- sysvinit-2.86/src/reboot.h	2004-06-09 14:47:45.000000000 +0200
+++ sysvinit-2.86-bifrost/src/reboot.h	2009-09-20 16:30:59.196712430 +0200
@@ -32,5 +32,8 @@
 #  define BMAGIC_POWEROFF	BMAGIC_HALT
 #endif
 
+/* for kexec support */
+#define BMAGIC_KEXEC  0x45584543
+
 #define init_reboot(magic)	reboot(magic)
 
diff -ur sysvinit-2.86/src/utmp.c sysvinit-2.86-bifrost/src/utmp.c
--- sysvinit-2.86/src/utmp.c	1999-06-09 13:11:33.000000000 +0200
+++ sysvinit-2.86-bifrost/src/utmp.c	2009-09-20 16:31:18.302711082 +0200
@@ -47,6 +47,7 @@
 	int fd;
 	struct utmp utmp;
 	struct utsname uname_buf;
+	struct timeval tv;
 
 	/*
 	 *	Try to open the wtmp file. Note that we even try
@@ -76,7 +77,9 @@
 	 */
 	memset(&utmp, 0, sizeof(utmp));
 #if defined(__GLIBC__)
-	gettimeofday(&utmp.ut_tv, NULL);
+	gettimeofday(&tv, NULL);
+	utmp.ut_tv.tv_sec = tv.tv_sec;
+	utmp.ut_tv.tv_usec = tv.tv_usec;
 #else
 	time(&utmp.ut_time);
 #endif
@@ -113,6 +116,7 @@
 	struct utmp utmp;
 	struct utmp tmp;
 	struct utmp *utmptr;
+	struct timeval tv;
 
 	/*
 	 *	Can't do much if UTMP_FILE is not present.
@@ -144,7 +148,9 @@
 	utmp.ut_pid = pid;
 	strncpy(utmp.ut_id, id, sizeof(utmp.ut_id));
 #if defined(__GLIBC__)
-	gettimeofday(&utmp.ut_tv, NULL);
+	gettimeofday(&tv, NULL);
+	utmp.ut_tv.tv_sec = tv.tv_sec;
+	utmp.ut_tv.tv_usec = tv.tv_usec;
 #else
 	time(&utmp.ut_time);
 #endif
