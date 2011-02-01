--- gps.h.orig	Fri Jun 11 09:21:42 2010
+++ gps.h	Mon Jan 24 14:02:15 2011
@@ -1114,5 +1114,7 @@
 }  /* End of the 'extern "C"' block */
 #endif
 
+#define finite(x) __finite(x)
+
 /* gps.h ends here */
 #endif /* _GPSD_GPS_H_ */
