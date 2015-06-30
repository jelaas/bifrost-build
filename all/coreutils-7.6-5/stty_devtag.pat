--- src/stty.c.orig	2011-06-01 12:57:45.271641681 +0200
+++ src/stty.c	2011-06-01 12:59:11.286641685 +0200
@@ -57,6 +57,8 @@
 #include <getopt.h>
 #include <stdarg.h>
 
+#include <devtag.h>
+
 #include "system.h"
 #include "error.h"
 #include "fd-reopen.h"
@@ -790,7 +792,7 @@
         case 'F':
           if (file_name)
             error (EXIT_FAILURE, 0, _("only one device may be specified"));
-          file_name = optarg;
+          file_name = devtag_get(optarg);
           break;
 
         case_GETOPT_HELP_CHAR;
