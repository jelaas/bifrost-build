--- common/argus_filter.c.orig	Thu May 10 09:19:56 2012
+++ common/argus_filter.c	Thu May 10 09:20:10 2012
@@ -888,7 +888,7 @@
    return (0);
 }
 
-#ifndef HAVE_SYS_ERRLIST
+#ifdef HAVE_SYS_ERRLIST
 static char ArgusErrorString[128];
 #endif
 
@@ -896,7 +896,7 @@
 char *
 argus_strerror(int errnum)
 {
-#ifndef HAVE_SYS_ERRLIST
+#ifdef HAVE_SYS_ERRLIST
    extern int sys_nerr;
    extern char *sys_errlist[];
 
