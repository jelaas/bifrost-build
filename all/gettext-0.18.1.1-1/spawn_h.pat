--- gettext-tools/gnulib-lib/spawn.in.h~	Mon May 24 09:42:46 2010
+++ gettext-tools/gnulib-lib/spawn.in.h	Sun Oct 10 15:07:34 2010
@@ -36,6 +36,8 @@
 # include <signal.h>
 #endif
 
+#include <pthread.h>
+
 #include <sys/types.h>
 
 #ifndef __THROW
