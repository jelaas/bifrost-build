--- main.c.orig	2012-02-22 13:25:04.241403918 +0100
+++ main.c	2012-02-22 13:25:54.838401845 +0100
@@ -45,6 +45,8 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 
+#include <devtag.h>
+
 #include "avr.h"
 #include "config.h"
 #include "confwin.h"
@@ -468,7 +470,7 @@
         break;
 
       case 'P':
-        port = optarg;
+        port = devtag_get(optarg);
         break;
 
       case 'q' : /* Quell progress output */
