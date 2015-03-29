--- agent/mibgroup/util_funcs/get_pid_from_inode.c~	Mon Dec  8 21:23:22 2014
+++ agent/mibgroup/util_funcs/get_pid_from_inode.c	Wed Feb 25 13:49:20 2015
@@ -17,6 +17,7 @@
 #if HAVE_UNISTD_H
 #include <unistd.h>
 #endif
+#include <limits.h>
 
 # define PROC_PATH          "/proc"
 # define SOCKET_TYPE_1      "socket:["
