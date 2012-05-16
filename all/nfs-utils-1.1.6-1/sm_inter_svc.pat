--- utils/statd/sm_inter_svc.c~	Wed May 16 12:08:00 2012
+++ utils/statd/sm_inter_svc.c	Wed May 16 12:11:39 2012
@@ -7,7 +7,7 @@
 #include <stdio.h>
 #include <stdlib.h>/* getenv, exit */
 #include <signal.h>
-#include <sys/ttycom.h>/* TIOCNOTTY */
+// #include <sys/ttycom.h>/* TIOCNOTTY */
 #include <memory.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
