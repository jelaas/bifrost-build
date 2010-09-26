--- sbin/mkfs/mkfs.c.orig	Sat Sep  4 20:54:21 2010
+++ sbin/mkfs/mkfs.c	Sat Sep  4 20:55:57 2010
@@ -90,6 +90,21 @@
 #define max_t(type,x,y) \
 	({ type __x = (x); type __y = (y); __x > __y ? __x : __y; })
 
+#include <stdlib.h>
+#include <malloc.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <sys/param.h>
+
+int posix_memalign(void **memptr, size_t alignment, size_t size)
+{
+       /* Make sure alignment is correct. */
+       if (alignment % sizeof(void *) != 0)
+               return EINVAL;
+       *memptr = memalign(alignment, size);
+       return (*memptr != NULL ? 0 : ENOMEM);
+}
+
 /*
  * System primitives
  */
