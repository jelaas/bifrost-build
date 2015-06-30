--- src/ct.c~	Mon Oct  6 15:42:51 2014
+++ src/ct.c	Mon Oct  6 15:45:00 2014
@@ -16,6 +16,7 @@
 #include <stdint.h>
 #include <string.h>
 
+#include <linux/types.h>
 #include <linux/netfilter/nf_tables.h>
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_conntrack_tuple_common.h>
