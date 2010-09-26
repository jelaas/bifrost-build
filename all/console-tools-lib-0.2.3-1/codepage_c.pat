--- contrib/codepage.c~	1999-04-08 23:29:41.000000000 +0200
+++ contrib/codepage.c	2009-09-20 18:17:02.342711648 +0200
@@ -228,8 +228,8 @@
 	  return 0;
 
         fprintf(stderr, "\
-Warning: CP format is a hack!\n
-         The files produced may or may not be usable!\n");
+Warning: CP format is a hack!\n"
+         "The files produced may or may not be usable!\n");
 
 	sprintf(outfile, "%d.cp", CPEntryHeader.codepage);
 	if ((out = fopen(outfile, "w")) == NULL) {
