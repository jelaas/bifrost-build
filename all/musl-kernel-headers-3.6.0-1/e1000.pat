--- kernel-3.3.0-rc2/drivers/net/ethernet/intel/e1000/e1000_main.c	Tue Feb  7 10:32:25 2012
+++ kernel-3.3.0-rc2-bifrost/drivers/net/ethernet/intel/e1000/e1000_main.c	Tue Feb  7 12:54:07 2012
@@ -179,7 +179,7 @@
 static void e1000_netpoll (struct net_device *netdev);
 #endif
 
-#define COPYBREAK_DEFAULT 256
+#define COPYBREAK_DEFAULT 0
 static unsigned int copybreak __read_mostly = COPYBREAK_DEFAULT;
 module_param(copybreak, uint, 0644);
 MODULE_PARM_DESC(copybreak,
