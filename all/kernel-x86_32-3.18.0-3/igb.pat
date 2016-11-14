--- kernel-3.17.0.orig/drivers/net/ethernet/intel/igb/igb.h	Wed Oct  8 09:18:02 2014
+++ kernel-3.17.0/drivers/net/ethernet/intel/igb/igb.h	Wed Oct  8 09:26:39 2014
@@ -59,7 +59,7 @@
 #define IGB_MIN_RXD		80
 #define IGB_MAX_RXD		4096
 
-#define IGB_DEFAULT_ITR		3 /* dynamic */
+#define IGB_DEFAULT_ITR		0
 #define IGB_MAX_ITR_USECS	10000
 #define IGB_MIN_ITR_USECS	10
 #define NON_Q_VECTORS		1
