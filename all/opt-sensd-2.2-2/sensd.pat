--- sensd/sensd.c.orig	Sun Jun  9 15:52:45 2013
+++ sensd/sensd.c	Sun Jun  9 15:52:56 2013
@@ -27,9 +27,8 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <termio.h>
+#include <termios.h>
 #include <time.h>
-#include <sys/fcntl.h>
 #include <fcntl.h>
 #include <string.h>
 #include <libgen.h>
