diff -urN sysklogd-1.4.1/BIFROST sysklogd-1.4.1-bifrost/BIFROST
--- sysklogd-1.4.1/BIFROST	1970-01-01 01:00:00.000000000 +0100
+++ sysklogd-1.4.1-bifrost/BIFROST	2009-11-11 13:10:05.236203358 +0100
@@ -0,0 +1,38 @@
+--- Makefile~	Fri May 15 08:41:42 2009
++++ Makefile	Fri May 15 08:43:36 2009
+@@ -3,8 +3,8 @@
+ CC= gcc
+ #CFLAGS= -g -DSYSV -Wall
+ #LDFLAGS= -g
+-CFLAGS= $(RPM_OPT_FLAGS) -DSYSV -D_GNU_SOURCE -Wall
+-LDFLAGS= -s
++CFLAGS= $(RPM_OPT_FLAGS) -DSYSV -D_GNU_SOURCE -Wall -march=i586
++LDFLAGS= -s -static
+ 
+ # Look where your install program is.
+ INSTALL = /usr/bin/install
+@@ -44,7 +44,7 @@
+ # ballot below.
+ SYSLOGD_PIDNAME = -DSYSLOGD_PIDNAME=\"syslogd.pid\"
+ 
+-SYSLOGD_FLAGS= -DSYSLOG_INET -DSYSLOG_UNIXAF -DNO_SCCS ${FSSTND} \
++SYSLOGD_FLAGS= -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DSYSLOG_INET -DSYSLOG_UNIXAF -DNO_SCCS ${FSSTND} \
+ 	${SYSLOGD_PIDNAME}
+ SYSLOG_FLAGS= -DALLOW_KERNEL_LOGGING
+ KLOGD_FLAGS = ${FSSTND} ${KLOGD_START_DELAY}
+--- syslogd.c~	Sun Mar 11 19:40:10 2001
++++ syslogd.c	Wed Nov 11 12:08:41 2009
+@@ -890,11 +890,12 @@
+ 		dprintf("Checking pidfile.\n");
+ 		if (!check_pid(PidFile))
+ 		{
++				signal (SIGTERM, doexit);
+ 			if (fork()) {
+ 				/*
+ 				 * Parent process
+ 				 */
+-				signal (SIGTERM, doexit);
++				//signal (SIGTERM, doexit);
+ 				sleep(300);
+ 				/*
+ 				 * Not reached unless something major went wrong.  5
diff -urN sysklogd-1.4.1/Makefile sysklogd-1.4.1-bifrost/Makefile
--- sysklogd-1.4.1/Makefile	1998-10-12 22:25:15.000000000 +0200
+++ sysklogd-1.4.1-bifrost/Makefile	2009-05-15 10:43:36.000000000 +0200
@@ -3,8 +3,8 @@
 CC= gcc
 #CFLAGS= -g -DSYSV -Wall
 #LDFLAGS= -g
-CFLAGS= $(RPM_OPT_FLAGS) -O3 -DSYSV -fomit-frame-pointer -Wall -fno-strength-reduce
-LDFLAGS= -s
+CFLAGS= $(RPM_OPT_FLAGS) -DSYSV -D_GNU_SOURCE -Wall -march=i586
+LDFLAGS= -s -static
 
 # Look where your install program is.
 INSTALL = /usr/bin/install
@@ -44,7 +44,7 @@
 # ballot below.
 SYSLOGD_PIDNAME = -DSYSLOGD_PIDNAME=\"syslogd.pid\"
 
-SYSLOGD_FLAGS= -DSYSLOG_INET -DSYSLOG_UNIXAF -DNO_SCCS ${FSSTND} \
+SYSLOGD_FLAGS= -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DSYSLOG_INET -DSYSLOG_UNIXAF -DNO_SCCS ${FSSTND} \
 	${SYSLOGD_PIDNAME}
 SYSLOG_FLAGS= -DALLOW_KERNEL_LOGGING
 KLOGD_FLAGS = ${FSSTND} ${KLOGD_START_DELAY}
diff -urN sysklogd-1.4.1/ksym.c sysklogd-1.4.1-bifrost/ksym.c
--- sysklogd-1.4.1/ksym.c	2000-09-12 23:53:31.000000000 +0200
+++ sysklogd-1.4.1-bifrost/ksym.c	2010-03-29 09:45:35.083641803 +0200
@@ -349,12 +349,13 @@
 			sprintf (symfile, "%s", *mf);
 			if ( debugging )
 				fprintf(stderr, "Trying %s.\n", symfile);
+			if (sym_file )  { fclose(sym_file); sym_file = NULL; }
 			if ( (sym_file = fopen(symfile, "r")) != (FILE *) 0 ) {
 				if (CheckMapVersion(symfile) == 1)
 					file = symfile;
 			}
 		}
-
+		if (sym_file ) { fclose(sym_file); sym_file = NULL; }
 	}
 
 	/*
diff -urN sysklogd-1.4.1/ksym_mod.c sysklogd-1.4.1-bifrost/ksym_mod.c
--- sysklogd-1.4.1/ksym_mod.c	2000-09-12 23:15:28.000000000 +0200
+++ sysklogd-1.4.1-bifrost/ksym_mod.c	2009-05-15 10:41:42.000000000 +0200
@@ -93,7 +93,7 @@
 #include <linux/time.h>
 #include <linux/module.h>
 #else /* __GLIBC__ */
-#include <linux/module.h>
+#include "module.h"
 extern __off64_t lseek64 __P ((int __fd, __off64_t __offset, int __whence));
 extern int get_kernel_syms __P ((struct kernel_sym *__table));
 #endif /* __GLIBC__ */
diff -urN sysklogd-1.4.1/module.h sysklogd-1.4.1-bifrost/module.h
--- sysklogd-1.4.1/module.h	1970-01-01 01:00:00.000000000 +0100
+++ sysklogd-1.4.1-bifrost/module.h	2009-05-15 10:41:42.000000000 +0200
@@ -0,0 +1,62 @@
+/* this file eliminates the need to include <kernel/module.h> */
+/* Module definitions for klogd's module support */
+struct kernel_sym
+{
+	        unsigned long value;
+	        char name[60];
+};
+
+struct module_symbol
+{
+	unsigned long value;
+	const char *name;
+};
+
+struct module_ref
+{
+	struct module *dep;     /* "parent" pointer */
+	struct module *ref;     /* "child" pointer */
+	struct module_ref *next_ref;
+};
+
+struct module_info
+{
+	unsigned long addr;
+	unsigned long size;
+	unsigned long flags;
+	long usecount;
+};
+
+
+typedef struct { volatile int counter; } atomic_t;
+
+struct module
+{
+	unsigned long size_of_struct;   /* == sizeof(module) */
+	struct module *next;
+	const char *name;
+	unsigned long size;
+	
+	union
+	{
+		atomic_t usecount;
+		long pad;
+        } uc;                           /* Needs to keep its size - so says rth */
+	
+	unsigned long flags;            /* AUTOCLEAN et al */
+	
+	unsigned nsyms;
+	unsigned ndeps;
+	
+	struct module_symbol *syms;
+	struct module_ref *deps;
+	struct module_ref *refs;
+	int (*init)(void);
+	void (*cleanup)(void);
+	const struct exception_table_entry *ex_table_start;
+	const struct exception_table_entry *ex_table_end;
+#ifdef __alpha__
+	unsigned long gp;
+#endif
+};
+	
diff -urN sysklogd-1.4.1/syslogd.c sysklogd-1.4.1-bifrost/syslogd.c
--- sysklogd-1.4.1/syslogd.c	2001-03-11 20:40:10.000000000 +0100
+++ sysklogd-1.4.1-bifrost/syslogd.c	2009-11-11 13:08:41.851203538 +0100
@@ -890,11 +890,12 @@
 		dprintf("Checking pidfile.\n");
 		if (!check_pid(PidFile))
 		{
+				signal (SIGTERM, doexit);
 			if (fork()) {
 				/*
 				 * Parent process
 				 */
-				signal (SIGTERM, doexit);
+				//signal (SIGTERM, doexit);
 				sleep(300);
 				/*
 				 * Not reached unless something major went wrong.  5
