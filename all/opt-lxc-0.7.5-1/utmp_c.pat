--- ./src/lxc/utmp.c.orig	Wed Aug 31 11:57:42 2011
+++ ./src/lxc/utmp.c	Wed Aug 31 12:39:07 2011
@@ -29,17 +29,29 @@
 #include <fcntl.h>
 #include <sys/inotify.h>
 #include <sys/ioctl.h>
-#include <sys/timerfd.h>
 
+/* #include <sys/timerfd.h> */
+#include <sys/syscall.h>
+/* Bits to be set in the FLAGS parameter of `timerfd_create'.  */
+enum {
+    	TFD_CLOEXEC = 02000000,
+#define TFD_CLOEXEC TFD_CLOEXEC
+ 	TFD_NONBLOCK = 04000
+#define TFD_NONBLOCK TFD_NONBLOCK
+  };
+#define timerfd_create(clockid,flags) syscall(__NR_timerfd_create, clockid, flags)
+#define timerfd_settime(fd, flags, new_value, old_value)\
+ syscall(__NR_timerfd_settime, fd, flags, new_value, old_value)
+
+
+#include <utmp.h>
+
 #include "conf.h"
 #include "cgroup.h"
 #include "start.h"
 #include "mainloop.h"
 #include "lxc.h"
 #include "log.h"
-#define __USE_GNU
-#include <utmpx.h>
-#undef __USE_GNU
 
 /* This file watches the /var/run/utmp file in the container
  * (that should probably be configurable)
@@ -166,7 +178,7 @@
 
 static int utmp_get_runlevel(struct lxc_utmp *utmp_data)
 {
-	struct utmpx *utmpx;
+	struct utmp *utmp;
 	char path[MAXPATHLEN];
 	struct lxc_handler *handler = utmp_data->handler;
 
@@ -176,7 +188,7 @@
 		return -1;
 	}
 
-	if (!access(path, F_OK) && !utmpxname(path))
+	if (!access(path, F_OK) && !utmpname(path))
 		goto utmp_ok;
 
 	if (snprintf(path, MAXPATHLEN, "/proc/%d/root/var/run/utmp",
@@ -185,27 +197,27 @@
 		return -1;
 	}
 
-	if (utmpxname(path)) {
+	if (utmpname(path)) {
 		SYSERROR("failed to 'utmpxname'");
 		return -1;
 	}
 
 utmp_ok:
 
-	setutxent();
+	setutent();
 
-	while ((utmpx = getutxent())) {
+	while ((utmp = getutent())) {
 
-		if (utmpx->ut_type == RUN_LVL) {
-			utmp_data->prev_runlevel = utmpx->ut_pid / 256;
-			utmp_data->curr_runlevel = utmpx->ut_pid % 256;
+		if (utmp->ut_type == RUN_LVL) {
+			utmp_data->prev_runlevel = utmp->ut_pid / 256;
+			utmp_data->curr_runlevel = utmp->ut_pid % 256;
 			DEBUG("utmp handler - run level is %c/%c",
 			      utmp_data->prev_runlevel,
 			      utmp_data->curr_runlevel);
 		}
 	}
 
-	endutxent();
+	endutent();
 
 	return 0;
 }
