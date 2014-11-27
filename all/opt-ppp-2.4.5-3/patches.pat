--- include/net/ppp_defs.h~	Mon Nov 16 23:26:07 2009
+++ include/net/ppp_defs.h	Tue Nov 19 08:29:46 2013
@@ -38,6 +38,8 @@
 #ifndef _PPP_DEFS_H_
 #define _PPP_DEFS_H_
 
+#include <time.h>
+
 /*
  * The basic PPP frame.
  */
