--- lib/fuse_lowlevel.c.orig	Thu May  3 10:13:05 2012
+++ lib/fuse_lowlevel.c	Thu May  3 10:13:45 2012
@@ -428,6 +428,21 @@
 	return send_reply_ok(req, buf, size);
 }
 
+int posix_memalign(void **memptr, size_t alignment, size_t size)
+	{
+	    /* Make sure alignment is correct. */
+	    if (alignment % sizeof(void *) != 0)
+	        /* Skip these checks because the memalign() func does them for us
+	         || !powerof2(alignment / sizeof(void *)) != 0
+	         || alignment == 0
+	         */
+	        return EINVAL;
+	
+	    *memptr = memalign(alignment, size);
+	
+	    return (*memptr != NULL ? 0 : ENOMEM);
+}
+
 static int fuse_send_data_iov_fallback(struct fuse_ll *f, struct fuse_chan *ch,
 				       struct iovec *iov, int iov_count,
 				       struct fuse_bufvec *buf,
