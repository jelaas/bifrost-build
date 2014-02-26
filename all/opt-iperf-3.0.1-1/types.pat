--- src/timer.h~	Fri Jan 10 22:22:11 2014
+++ src/timer.h	Wed Feb 26 10:18:33 2014
@@ -13,6 +13,7 @@
 #define __TIMER_H
 
 #include <sys/time.h>
+#include <sys/types.h>
 
 /* TimerClientData is an opaque value that tags along with a timer.  The
 ** client can use it for whatever, and it gets passed to the callback when
--- src/cjson.h~	Fri Jan 10 22:22:11 2014
+++ src/cjson.h	Wed Feb 26 10:19:10 2014
@@ -23,6 +23,8 @@
 #ifndef cJSON__h
 #define cJSON__h
 
+#include <sys/types.h>
+
 #ifdef __cplusplus
 extern "C"
 {
