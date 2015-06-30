--- kernel-3.3.0-rc2/drivers/net/ethernet/intel/e1000e/param.c	Tue Feb  7 10:32:25 2012
+++ kernel-3.3.0-rc2-bifrost/drivers/net/ethernet/intel/e1000e/param.c	Tue Feb  7 12:54:07 2012
@@ -43,7 +43,7 @@
 #define OPTION_DISABLED 0
 #define OPTION_ENABLED  1
 
-#define COPYBREAK_DEFAULT 256
+#define COPYBREAK_DEFAULT 0
 unsigned int copybreak = COPYBREAK_DEFAULT;
 module_param(copybreak, uint, 0644);
 MODULE_PARM_DESC(copybreak,
