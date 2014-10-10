--- utils/teamnl.c~	Tue Aug 19 09:21:46 2014
+++ utils/teamnl.c	Fri Oct 10 16:02:08 2014
@@ -27,6 +27,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <team.h>
+#include <sys/select.h>
 
 #include <private/misc.h>
 
