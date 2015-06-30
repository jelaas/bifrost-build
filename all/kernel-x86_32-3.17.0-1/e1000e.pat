--- kernel-3.17.0.orig/drivers/net/ethernet/intel/e1000e/param.c	Mon Oct  6 13:11:29 2014
+++ kernel-3.17.0/drivers/net/ethernet/intel/e1000e/param.c	Wed Oct  8 09:25:09 2014
@@ -34,7 +34,7 @@
 #define OPTION_DISABLED 0
 #define OPTION_ENABLED  1
 
-#define COPYBREAK_DEFAULT 256
+#define COPYBREAK_DEFAULT 0
 unsigned int copybreak = COPYBREAK_DEFAULT;
 module_param(copybreak, uint, 0644);
 MODULE_PARM_DESC(copybreak,
@@ -92,7 +92,7 @@
  * Valid Range: 100-100000 or one of: 0=off, 1=dynamic, 3=dynamic conservative
  */
 E1000_PARAM(InterruptThrottleRate, "Interrupt Throttling Rate");
-#define DEFAULT_ITR 3
+#define DEFAULT_ITR 0
 #define MAX_ITR 100000
 #define MIN_ITR 100
 
