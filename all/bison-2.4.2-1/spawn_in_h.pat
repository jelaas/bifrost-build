--- lib/spawn.in.h.orig	2010-05-23 14:35:48.977614755 +0200
+++ lib/spawn.in.h	2010-05-23 14:36:24.439608385 +0200
@@ -31,6 +31,7 @@
 
 /* Get definitions of 'struct sched_param' and 'sigset_t'.
    But avoid namespace pollution on glibc systems.  */
+# include <sched.h>
 #ifndef __GLIBC__
 # include <sched.h>
 # include <signal.h>
