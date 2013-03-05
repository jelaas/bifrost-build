--- ./grub-core/kern/misc.c.orig	Fri Aug 24 18:16:02 2012
+++ ./grub-core/kern/misc.c	Fri Aug 24 18:16:46 2012
@@ -64,19 +64,13 @@
   return dest;
 }
 
-#ifndef __APPLE__
-void *memmove (void *dest, const void *src, grub_size_t n)
-  __attribute__ ((alias ("grub_memmove")));
-/* GCC emits references to memcpy() for struct copies etc.  */
-void *memcpy (void *dest, const void *src, grub_size_t n)
-  __attribute__ ((alias ("grub_memmove")));
-#else
-void * __attribute__ ((regparm(0)))
+#ifndef GRUB_UTIL
+void *
 memcpy (void *dest, const void *src, grub_size_t n)
 {
 	return grub_memmove (dest, src, n);
 }
-void * __attribute__ ((regparm(0)))
+void *
 memmove (void *dest, const void *src, grub_size_t n)
 {
 	return grub_memmove (dest, src, n);
