--- lib/fontstruct.c~	1999-08-31 22:43:15.000000000 +0200
+++ lib/fontstruct.c	2009-09-20 18:11:43.843711786 +0200
@@ -42,7 +42,7 @@
    */
   
   /* FIXME: should not use _fileno ! */
-  if (fstat(fontfile->_fileno, &stbuf) == -1)
+  if (fstat(fileno(fontfile), &stbuf) == -1)
     goto rsf_return_error;
   
   if (S_ISREG(stbuf.st_mode))
