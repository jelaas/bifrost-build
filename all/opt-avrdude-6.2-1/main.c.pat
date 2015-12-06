--- main.c.orig	Sun Dec  6 13:14:55 2015
+++ main.c	Sun Dec  6 13:15:03 2015
@@ -45,6 +45,8 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 
+#include <devtag.h>
+
 #include "avrdude.h"
 #include "libavrdude.h"
 
@@ -580,7 +582,7 @@
         break;
 
       case 'P':
-        port = optarg;
+	port = devtag_get(optarg);
         break;
 
       case 'q' : /* Quell progress output */
