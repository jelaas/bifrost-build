--- deps/uv/src/fs-poll.c~	Sat Jan 26 17:09:43 2013
+++ deps/uv/src/fs-poll.c	Sat Jan 26 19:07:43 2013
@@ -195,7 +195,7 @@
 
   /* Jump through a few hoops to get sub-second granularity on Linux. */
 # if __linux__
-#  if __USE_MISC /* _BSD_SOURCE || _SVID_SOURCE */
+#  if 0
   if (a->st_ctim.tv_nsec != b->st_ctim.tv_nsec) return 0;
   if (a->st_mtim.tv_nsec != b->st_mtim.tv_nsec) return 0;
 #  else
