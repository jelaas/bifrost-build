--- kernel-3.17.0.orig/include/uapi/linux/if_bonding.h	Mon Oct  6 13:11:32 2014
+++ kernel-3.17.0/include/uapi/linux/if_bonding.h	Wed Oct  8 09:27:14 2014
@@ -81,7 +81,7 @@
 #define BOND_STATE_ACTIVE       0   /* link is active */
 #define BOND_STATE_BACKUP       1   /* link is backup */
 
-#define BOND_DEFAULT_MAX_BONDS  1   /* Default maximum number of devices to support */
+#define BOND_DEFAULT_MAX_BONDS  0   /* Default maximum number of devices to support */
 
 #define BOND_DEFAULT_TX_QUEUES 16   /* Default number of tx queues per device */
 
