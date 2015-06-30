--- src/emacs.c.orig	Thu Jun  3 13:06:17 2010
+++ src/emacs.c	Thu Jun  3 13:06:28 2010
@@ -423,7 +423,7 @@
    so that GDB can return from a breakpoint here.
    MSDOS has its own definition in msdos.c.  */
 
-#if ! defined (DOS_NT) && ! defined (NO_ABORT)
+#if 0
 
 void
 abort ()
