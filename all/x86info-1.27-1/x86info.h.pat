--- x86info.h.orig	Thu Sep 30 08:22:15 2010
+++ x86info.h	Thu Sep 30 08:22:30 2010
@@ -207,8 +207,8 @@
 	cpu_set_t set;
 
 	if (sched_getaffinity(getpid(), sizeof(set), &set) == 0) {
-		CPU_ZERO(&set);
-		CPU_SET(cpu->number, &set);
+		__CPU_ZERO(&set);
+		__CPU_SET(cpu->number, &set);
 		sched_setaffinity(getpid(), sizeof(set), &set);
 	}
 }
