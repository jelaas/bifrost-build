--- proc/sysinfo.c.orig	2010-07-23 13:56:28.353963762 +0200
+++ proc/sysinfo.c	2010-07-23 14:01:16.475961306 +0200
@@ -209,6 +209,32 @@
   return !!rc;
 }
 
+int cpu_online()
+{
+  int fd, n, nr_cpu=0;
+  char fn[256];
+  char buf[16], *p;
+  
+  nr_cpu=0;
+  
+  fd = open("/sys/devices/system/cpu/online", O_RDONLY);
+  if(fd == -1) return -1;
+  n = read(fd, buf, sizeof(buf)-1);
+  close(fd);
+  if(n < 1 ) return -1;
+  
+  buf[n] = 0;
+  p = strchr(buf, '-');
+  if(!p) {
+    return 1;
+  }
+  
+  nr_cpu = atoi(p+1);
+  nr_cpu++;
+  
+  return nr_cpu;
+}
+
 static void init_libproc(void) __attribute__((constructor));
 static void init_libproc(void){
   have_privs = check_for_privs();
@@ -219,7 +245,8 @@
   // appears to have a non-SMP kernel on a 2-way SMP box.
   // _SC_NPROCESSORS_CONF returns 2, resulting in HZ=512
   // _SC_NPROCESSORS_ONLN returns 1, which should work OK
-  smp_num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+  smp_num_cpus = cpu_online();
+
   if(smp_num_cpus<1) smp_num_cpus=1; /* SPARC glibc is buggy */
 
   if(linux_version_code > LINUX_VERSION(2, 4, 0)){ 
