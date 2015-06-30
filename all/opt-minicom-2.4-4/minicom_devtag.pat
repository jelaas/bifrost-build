diff -ur minicom-2.4-orig/src/main.c minicom-2.4/src/main.c
--- minicom-2.4-orig/src/main.c	2009-12-12 16:47:47.000000000 +0100
+++ minicom-2.4/src/main.c	2011-06-01 16:14:30.837257886 +0200
@@ -37,6 +37,8 @@
 #include <sys/mkdev.h>
 #endif /* SVR4_LOCKS */
 
+#include <devtag.h>
+
 static jmp_buf albuf;
 
 /* Compile SCCS ID into executable. */
@@ -165,7 +167,7 @@
   if (P_LOCK[0] && stat(P_LOCK, &stt) == 0) {
 
 #ifdef SVR4_LOCKS
-    stat(dial_tty, &stt);
+	  stat(devtag_get(dial_tty), &stt);
     sprintf(lockfile, "%s/LK.%03d.%03d.%03d",
                       P_LOCK, major(stt.st_dev),
                       major(stt.st_rdev), minor(stt.st_rdev));
@@ -173,7 +175,7 @@
 #else /* SVR4_LOCKS */
     snprintf(lockfile, sizeof(lockfile),
                        "%s/LCK..%s",
-                       P_LOCK, mbasename(dial_tty, buf, sizeof(buf)));
+	     P_LOCK, mbasename(devtag_get(dial_tty), buf, sizeof(buf)));
 #endif /* SVR4_LOCKS */
 
   }
@@ -244,7 +246,7 @@
 #endif /* USE_SOCKET */
     if (!portfd_is_socket) {
 #if defined(O_NDELAY) && defined(F_SETFL)
-      portfd = open(dial_tty, O_RDWR|O_NDELAY|O_NOCTTY);
+	    portfd = open(devtag_get(dial_tty), O_RDWR|O_NDELAY|O_NOCTTY);
       if (portfd >= 0) {
         /* Cancel the O_NDELAY flag. */
         n = fcntl(portfd, F_GETFL, 0);
@@ -252,7 +254,7 @@
       }
 #else
       if (portfd < 0)
-        portfd = open(dial_tty, O_RDWR|O_NOCTTY);
+	      portfd = open(devtag_get(dial_tty), O_RDWR|O_NOCTTY);
 #endif
     }
     if (portfd >= 0) {
