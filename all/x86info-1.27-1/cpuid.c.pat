--- cpuid.c.orig	Thu Sep 30 08:13:53 2010
+++ cpuid.c	Thu Sep 30 08:20:34 2010
@@ -10,6 +10,9 @@
 
 #define _LARGEFILE64_SOURCE
 
+#define __USE_GNU
+#include <sched.h>
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -19,8 +22,6 @@
 #include <unistd.h>
 #include <errno.h>
 
-#define __USE_GNU
-#include <sched.h>
 
 #if defined(__FreeBSD__)
 # include <sys/ioctl.h>
@@ -29,17 +30,6 @@
 
 #include "x86info.h"
 
-/*
- * sched_* calls weren't stable until 2.3.4
- * AFAIK, there's no macro to check for the .4, so we just
- * check for the next minor version up. (2.4)
- */
-#ifdef __GLIBC__
-#if __GLIBC__ < 2 || __GLIBC__ == 2 && __GLIBC_MINOR__ < 4
-#error Need at least glibc 2.4
-#endif
-#endif
-
 /* returns zero on success */
 static int native_cpuid(unsigned int cpunr, unsigned long long idx,
 	unsigned int *eax, unsigned int *ebx,
@@ -64,8 +54,8 @@
 
 	/* man CPU_SET(3): To duplicate a CPU set, use memcpy(3) */
 	memcpy(&tmp_set, &set, sizeof(cpu_set_t));
-	CPU_ZERO(&set);
-	CPU_SET(cpunr, &set);
+	__CPU_ZERO(&set);
+	__CPU_SET(cpunr, &set);
 	ret = sched_setaffinity(getpid(), sizeof(set), &set);
 	if (ret)
 		return ret;
