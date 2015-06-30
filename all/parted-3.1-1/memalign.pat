--- libparted/arch/linux.c.orig	Fri Aug 17 14:36:08 2012
+++ libparted/arch/linux.c	Fri Aug 17 14:36:52 2012
@@ -288,6 +288,21 @@
 static char* _device_get_part_path (PedDevice* dev, int num);
 static int _partition_is_mounted_by_path (const char* path);
 
+int posix_memalign(void **memptr, size_t alignment, size_t size)
+        {
+            /* Make sure alignment is correct. */
+            if (alignment % sizeof(void *) != 0)
+                /* Skip these checks because the memalign() func does them for us
+                 || !powerof2(alignment / sizeof(void *)) != 0
+                 || alignment == 0
+                 */
+                return EINVAL;
+        
+            *memptr = memalign(alignment, size);
+        
+            return (*memptr != NULL ? 0 : ENOMEM);
+}
+
 static int
 _read_fd (int fd, char **buf)
 {
