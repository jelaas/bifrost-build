--- ./grub-core/kern/emu/mm.c.orig	Fri Aug 24 14:04:08 2012
+++ ./grub-core/kern/emu/mm.c	Fri Aug 24 14:08:20 2012
@@ -25,6 +25,8 @@
 #include <string.h>
 #include <grub/i18n.h>
 
+#include <malloc.h>
+
 void *
 grub_malloc (grub_size_t size)
 {
