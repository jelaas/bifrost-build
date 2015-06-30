--- lib/netfilter/queue_msg.c~	Wed Oct  8 16:35:16 2014
+++ lib/netfilter/queue_msg.c	Wed Oct  8 16:37:00 2014
@@ -16,7 +16,7 @@
  * @brief
  * @{
  */
-
+#include <byteswap.h>
 #include <sys/types.h>
 #include <linux/netfilter/nfnetlink_queue.h>
 
