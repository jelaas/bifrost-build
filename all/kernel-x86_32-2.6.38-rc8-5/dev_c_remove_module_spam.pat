--- net/core/dev.c.orig	2011-05-18 11:07:28.998981195 +0200
+++ net/core/dev.c	2011-05-18 11:08:34.256981199 +0200
@@ -1125,10 +1125,7 @@
 	if (no_module && capable(CAP_NET_ADMIN))
 		no_module = request_module("netdev-%s", name);
 	if (no_module && capable(CAP_SYS_MODULE)) {
-		if (!request_module("%s", name))
-			pr_err("Loading kernel module for a network device "
-"with CAP_SYS_MODULE (deprecated).  Use CAP_NET_ADMIN and alias netdev-%s "
-"instead\n", name);
+		request_module("%s", name);
 	}
 }
 EXPORT_SYMBOL(dev_load);
