--- crypto/ui/ui_openssl.c.orig	Fri Mar 20 09:50:07 2015
+++ crypto/ui/ui_openssl.c	Fri Mar 20 09:50:39 2015
@@ -218,6 +218,9 @@
 
 #endif
 
+#define TERMIOS
+#undef TERMIO
+
 #ifdef TERMIOS
 # include <termios.h>
 # define TTY_STRUCT             struct termios
