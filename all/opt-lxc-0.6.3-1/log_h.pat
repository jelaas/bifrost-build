--- src/lxc/log.h~	2009-05-25 13:18:15.000000000 +0200
+++ src/lxc/log.h	2009-09-10 21:27:50.030815502 +0200
@@ -206,7 +206,7 @@
  */
 #define lxc_log_category_define(name, parent)				\
 	extern struct lxc_log_category lxc_log_category_##parent;	\
-	struct lxc_log_category lxc_log_category_##name = {		\
+	static struct lxc_log_category lxc_log_category_##name = {		\
 		#name,							\
 		LXC_LOG_PRIORITY_NOTSET,				\
 		NULL,							\
