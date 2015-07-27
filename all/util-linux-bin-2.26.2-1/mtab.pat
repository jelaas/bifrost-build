--- sys-utils/mount.c.orig	Wed Apr 29 12:21:50 2015
+++ sys-utils/mount.c	Mon Jul 27 14:43:22 2015
@@ -868,6 +868,8 @@
 
 	mnt_context_set_tables_errcb(cxt, table_parser_errcb);
 
+	mnt_context_disable_mtab(cxt, TRUE);
+
 	while ((c = getopt_long(argc, argv, "aBcfFhilL:Mno:O:rRsU:vVwt:T:",
 					longopts, NULL)) != -1) {
 
