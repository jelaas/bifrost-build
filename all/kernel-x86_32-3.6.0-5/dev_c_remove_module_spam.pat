--- net/core/dev.c.orig	Wed Oct  3 11:32:03 2012
+++ net/core/dev.c	Wed Oct  3 11:33:29 2012
@@ -1138,9 +1138,7 @@
 	if (no_module && capable(CAP_NET_ADMIN))
 		no_module = request_module("netdev-%s", name);
 	if (no_module && capable(CAP_SYS_MODULE)) {
-		if (!request_module("%s", name))
-			pr_warn("Loading kernel module for a network device with CAP_SYS_MODULE (deprecated).  Use CAP_NET_ADMIN and alias netdev-%s instead.\n",
-				name);
+		request_module("%s", name);
 	}
 }
 EXPORT_SYMBOL(dev_load);
