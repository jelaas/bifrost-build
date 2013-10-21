--- include/time.h.orig	Tue Jun  4 14:20:04 2013
+++ include/time.h	Tue Jun  4 14:20:29 2013
@@ -39,10 +39,6 @@
 	long __tm_gmtoff;
 	const char *__tm_zone;
 };
-#if defined(_BSD_SOURCE) || defined(_GNU_SOURCE)
-#define tm_gmtoff __tm_gmtoff
-#define tm_zone __tm_zone
-#endif
 
 clock_t clock (void);
 time_t time (time_t *);
