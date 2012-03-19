=== modified file 'storage/innobase/srv/srv0start.c'
--- storage/innobase/srv/srv0start.c	revid:rohit.kalhans@oracle.com-20120213100750-eetng55t69bqp319
+++ storage/innobase/srv/srv0start.c	2012-02-15 02:45:37 +0000
@@ -922,8 +922,9 @@ skip_size_check:
 #endif /* UNIV_LOG_ARCHIVE */
 				min_flushed_lsn, max_flushed_lsn);
 
-			if (UNIV_PAGE_SIZE
-			    != fsp_flags_get_page_size(flags)) {
+			if (!one_opened
+			    && UNIV_PAGE_SIZE
+			       != fsp_flags_get_page_size(flags)) {
 
 				ut_print_timestamp(stderr);
 				fprintf(stderr,

