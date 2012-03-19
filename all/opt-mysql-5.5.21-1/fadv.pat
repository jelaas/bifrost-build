--- storage/innobase/row/row0merge.c.orig	2012-03-15 23:30:16.157874321 +0100
+++ storage/innobase/row/row0merge.c	2012-03-15 23:34:13.087864626 +0100
@@ -717,7 +717,7 @@
 						 sizeof *buf);
 #ifdef POSIX_FADV_DONTNEED
 	/* Each block is read exactly once.  Free up the file cache. */
-	posix_fadvise(fd, ofs, sizeof *buf, POSIX_FADV_DONTNEED);
+//	posix_fadvise(fd, ofs, sizeof *buf, POSIX_FADV_DONTNEED);
 #endif /* POSIX_FADV_DONTNEED */
 
 	if (UNIV_UNLIKELY(!success)) {
@@ -760,7 +760,7 @@
 #ifdef POSIX_FADV_DONTNEED
 	/* The block will be needed on the next merge pass,
 	but it can be evicted from the file cache meanwhile. */
-	posix_fadvise(fd, ofs, buf_len, POSIX_FADV_DONTNEED);
+//	posix_fadvise(fd, ofs, buf_len, POSIX_FADV_DONTNEED);
 #endif /* POSIX_FADV_DONTNEED */
 
 	return(UNIV_LIKELY(ret));
@@ -1625,8 +1625,8 @@
 	/* The input file will be read sequentially, starting from the
 	beginning and the middle.  In Linux, the POSIX_FADV_SEQUENTIAL
 	affects the entire file.  Each block will be read exactly once. */
-	posix_fadvise(file->fd, 0, 0,
-		      POSIX_FADV_SEQUENTIAL | POSIX_FADV_NOREUSE);
+//	posix_fadvise(file->fd, 0, 0,
+//		      POSIX_FADV_SEQUENTIAL | POSIX_FADV_NOREUSE);
 #endif /* POSIX_FADV_SEQUENTIAL */
 
 	/* Merge blocks to the output file. */
