--- apps/speed.c.orig	Fri Mar 20 10:47:06 2015
+++ apps/speed.c	Fri Mar 20 10:47:44 2015
@@ -127,6 +127,10 @@
 # ifndef _IRIX
 #  include <time.h>
 # endif
+
+#undef TIMEB
+# define TIMES
+
 # ifdef TIMES
 #  include <sys/types.h>
 #  include <sys/times.h>
--- crypto/ui/ui_openssl.c.orig	Fri Mar 20 10:47:11 2015
+++ crypto/ui/ui_openssl.c	Fri Mar 20 10:48:12 2015
@@ -216,6 +216,9 @@
 # undef SGTTY
 #endif
 
+#define TERMIOS
+#undef TERMIO
+
 #ifdef TERMIOS
 # include <termios.h>
 # define TTY_STRUCT             struct termios
