--- libnuma.c.orig	2011-01-27 08:39:32.333697099 +0100
+++ libnuma.c	2011-01-27 12:03:00.156044471 +0100
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <ctype.h>
+#include <fcntl.h>
 
 #include <sys/mman.h>
 #include <limits.h>
@@ -62,6 +63,8 @@
 #warning "not threadsafe"
 #endif
 
+#define __thread
+
 static __thread int bind_policy = MPOL_BIND; 
 static __thread unsigned int mbind_flags = 0;
 static int sizes_set=0;
@@ -110,6 +113,30 @@
 		numa_bitmask_free(numa_nodes_ptr);
 }
 
+static int cpu_online()
+{
+	int fd, n;
+        char fn[256];
+        char buf[16], *p;
+
+	snprintf(fn, sizeof(fn), "%s/devices/system/cpu/online", "/sys");
+
+        fd = open(fn, O_RDONLY);
+        if(fd == -1) return -1;
+        n = read(fd, buf, sizeof(buf)-1);
+        if(n < 1 ) return -1;
+
+        close(fd);
+        buf[n] = 0;
+        p = strchr(buf, '-');
+        if(!p) {
+                /* single CPU system */
+                return 1;
+	}
+
+        return atoi(p+1)+1;
+}
+
 /*
  * The following bitmask declarations, bitmask_*() routines, and associated
  * _setbit() and _getbit() routines are:
@@ -460,7 +487,7 @@
 static void
 set_task_constraints(void)
 {
-	int hicpu = sysconf(_SC_NPROCESSORS_CONF)-1;
+	int hicpu = cpu_online()-1;
 	int i;
 	char *buffer = NULL;
 	size_t buflen = 0;
@@ -470,26 +497,6 @@
 	numa_all_nodes_ptr = numa_allocate_nodemask();
 	numa_no_nodes_ptr = numa_allocate_nodemask();
 
-	f = fopen(mask_size_file, "r");
-	if (!f) {
-		//numa_warn(W_cpumap, "Cannot parse %s", mask_size_file);
-		return;
-	}
-
-	while (getline(&buffer, &buflen, f) > 0) {
-		/* mask starts after [last] tab */
-		char  *mask = strrchr(buffer,'\t') + 1;
-
-		if (strncmp(buffer,"Cpus_allowed:",13) == 0)
-			numproccpu = read_mask(mask, numa_all_cpus_ptr);
-
-		if (strncmp(buffer,"Mems_allowed:",13) == 0) {
-			numprocnode = read_mask(mask, numa_all_nodes_ptr);
-		}
-	}
-	fclose(f);
-	free(buffer);
-
 	/*
 	 * Cpus_allowed in the kernel can be defined to all f's
 	 * i.e. it may be a superset of the actual available processors.
