--- lib/spawn.h~	2010-05-19 14:46:51.165609445 +0200
+++ lib/spawn.h	2010-05-19 15:15:10.130608422 +0200
@@ -32,6 +32,7 @@
 
 /* Get definitions of 'struct sched_param' and 'sigset_t'.
    But avoid namespace pollution on glibc systems.  */
+# include <sched.h>
 #ifndef __GLIBC__
 # include <sched.h>
 # include <signal.h>
