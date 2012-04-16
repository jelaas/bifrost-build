--- grub-core/kern/misc.c.orig	Mon Apr 18 21:16:16 2011
+++ grub-core/kern/misc.c	Mon Apr 16 12:45:50 2012
@@ -64,14 +64,8 @@
   return dest;
 }
 
-#ifndef APPLE_CC
-void *memmove (void *dest, const void *src, grub_size_t n)
-  __attribute__ ((alias ("grub_memmove")));
-/* GCC emits references to memcpy() for struct copies etc.  */
+#ifndef GRUB_UTIL
 void *memcpy (void *dest, const void *src, grub_size_t n)
-  __attribute__ ((alias ("grub_memmove")));
-#else
-void *memcpy (void *dest, const void *src, grub_size_t n)
 {
 	return grub_memmove (dest, src, n);
 }
@@ -557,10 +551,7 @@
 
   return s;
 }
-#ifndef APPLE_CC
-void *memset (void *s, int c, grub_size_t n)
-  __attribute__ ((alias ("grub_memset")));
-#else
+#ifndef GRUB_UTIL
 void *memset (void *s, int c, grub_size_t n)
 {
   return grub_memset (s, c, n);
