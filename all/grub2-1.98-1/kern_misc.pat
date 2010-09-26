--- kern/misc.c.orig	Sat Mar  6 20:51:37 2010
+++ kern/misc.c	Sun Sep  5 12:45:49 2010
@@ -64,23 +64,6 @@
   return dest;
 }
 
-#ifndef APPLE_CC
-void *memmove (void *dest, const void *src, grub_size_t n)
-  __attribute__ ((alias ("grub_memmove")));
-/* GCC emits references to memcpy() for struct copies etc.  */
-void *memcpy (void *dest, const void *src, grub_size_t n)
-  __attribute__ ((alias ("grub_memmove")));
-#else
-void *memcpy (void *dest, const void *src, grub_size_t n)
-{
-	return grub_memmove (dest, src, n);
-}
-void *memmove (void *dest, const void *src, grub_size_t n)
-{
-	return grub_memmove (dest, src, n);
-}
-#endif
-
 char *
 grub_strcpy (char *dest, const char *src)
 {
@@ -516,15 +499,6 @@
 
   return s;
 }
-#ifndef APPLE_CC
-void *memset (void *s, int c, grub_size_t n)
-  __attribute__ ((alias ("grub_memset")));
-#else
-void *memset (void *s, int c, grub_size_t n)
-{
-  return grub_memset (s, c, n);
-}
-#endif
 
 grub_size_t
 grub_strlen (const char *s)
@@ -1052,11 +1026,6 @@
 
   grub_exit ();
 }
-
-#ifndef APPLE_CC
-/* GCC emits references to abort().  */
-void abort (void) __attribute__ ((alias ("grub_abort")));
-#endif
 
 #ifdef NEED_ENABLE_EXECUTE_STACK
 /* Some gcc versions generate a call to this function
