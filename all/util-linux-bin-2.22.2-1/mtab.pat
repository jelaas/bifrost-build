--- sys-utils/mount.c.orig	Wed Feb 27 21:22:31 2013
+++ sys-utils/mount.c	Wed Feb 27 21:24:43 2013
@@ -830,6 +830,8 @@
 
 	mnt_context_set_tables_errcb(cxt, table_parser_errcb);
 
+	mnt_context_disable_mtab(cxt, TRUE);
+
 	while ((c = getopt_long(argc, argv, "aBcfFhilL:Mno:O:p:rRsU:vVwt:T:",
 					longopts, NULL)) != -1) {
 
