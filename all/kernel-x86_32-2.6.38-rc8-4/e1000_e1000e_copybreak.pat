diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index bfab140..0e66d8e 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -182,7 +182,7 @@ static void e1000_shutdown(struct pci_dev *pdev);
 static void e1000_netpoll (struct net_device *netdev);
 #endif
 
-#define COPYBREAK_DEFAULT 256
+#define COPYBREAK_DEFAULT 0
 static unsigned int copybreak __read_mostly = COPYBREAK_DEFAULT;
 module_param(copybreak, uint, 0644);
 MODULE_PARM_DESC(copybreak,
diff --git a/drivers/net/e1000e/param.c b/drivers/net/e1000e/param.c
index 4dd9b63..7b967e8 100644
--- a/drivers/net/e1000e/param.c
+++ b/drivers/net/e1000e/param.c
@@ -42,7 +42,7 @@
 #define OPTION_DISABLED 0
 #define OPTION_ENABLED  1
 
-#define COPYBREAK_DEFAULT 256
+#define COPYBREAK_DEFAULT 0
 unsigned int copybreak = COPYBREAK_DEFAULT;
 module_param(copybreak, uint, 0644);
 MODULE_PARM_DESC(copybreak,
