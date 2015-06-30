--- include/netlink-local.h.orig	Tue Oct  8 16:04:32 2013
+++ include/netlink-local.h	Tue Oct  8 16:17:50 2013
@@ -12,6 +12,8 @@
 #ifndef NETLINK_LOCAL_H_
 #define NETLINK_LOCAL_H_
 
+#include <byteswap.h>
+#include <limits.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
