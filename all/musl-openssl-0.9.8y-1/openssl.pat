--- apps/speed.c~	Thu Jul  8 01:23:25 2010
+++ apps/speed.c	Fri Sep 21 09:14:32 2012
@@ -126,6 +126,10 @@
 #ifndef _IRIX
 # include <time.h>
 #endif
+
+#undef TIMEB
+# define TIMES
+
 #ifdef TIMES
 # include <sys/types.h>
 # include <sys/times.h>
--- crypto/ui/ui_openssl.c.orig	Fri Sep 21 09:57:09 2012
+++ crypto/ui/ui_openssl.c	Fri Sep 21 09:57:30 2012
@@ -212,6 +212,9 @@
 #undef SGTTY
 #endif
 
+#define TERMIOS
+#undef TERMIO
+
 #ifdef TERMIOS
 # include <termios.h>
 # define TTY_STRUCT		struct termios
