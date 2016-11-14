--- kernel-3.17.0.orig/drivers/net/ethernet/intel/e1000/e1000_param.c	Mon Oct  6 13:11:29 2014
+++ kernel-3.17.0/drivers/net/ethernet/intel/e1000/e1000_param.c	Wed Oct  8 09:26:00 2014
@@ -176,7 +176,7 @@
  * Valid Range: 100-100000 (0=off, 1=dynamic, 3=dynamic conservative)
  */
 E1000_PARAM(InterruptThrottleRate, "Interrupt Throttling Rate");
-#define DEFAULT_ITR                    3
+#define DEFAULT_ITR                    0
 #define MAX_ITR                   100000
 #define MIN_ITR                      100
 
