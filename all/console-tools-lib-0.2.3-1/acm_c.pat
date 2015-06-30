--- lib/acm.c~	1999-04-09 00:11:13.000000000 +0200
+++ lib/acm.c	2009-09-20 18:12:20.636712950 +0200
@@ -31,7 +31,7 @@
   int parse_failed = 0;
   int is_unicode;
 
-  if (fstat(fp->_fileno, &stbuf)) 
+  if (fstat(fileno(fp), &stbuf)) 
     perror(_("Cannot stat map file")), exit(1);
 
   /* first try a UTF screen-map: either ASCII (no restriction) or binary (regular file) */
