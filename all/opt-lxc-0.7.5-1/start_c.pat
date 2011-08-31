--- ./src/lxc/start.c.orig	Wed Aug 31 12:18:40 2011
+++ ./src/lxc/start.c	Wed Aug 31 12:18:50 2011
@@ -120,7 +120,7 @@
 #include "af_unix.h"
 #include "mainloop.h"
 #include "utils.h"
-#include "utmp.h"
+#include "lxc__utmp.h"
 #include "monitor.h"
 #include "commands.h"
 #include "console.h"
