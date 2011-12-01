--- ./ldso/include/dl-elf.h.orig	Fri Sep 16 14:05:54 2011
+++ ./ldso/include/dl-elf.h	Fri Sep 16 14:08:15 2011
@@ -10,6 +10,7 @@
 
 #include <dl-string.h> /* before elf.h to get ELF_USES_RELOCA right */
 #include <elf.h>
+#define RTLD_NODELETE	0x01000
 #include <link.h>
 
 /* Forward declarations for stuff defined in ld_hash.h */
