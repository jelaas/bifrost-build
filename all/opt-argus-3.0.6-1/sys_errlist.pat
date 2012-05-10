--- common/argus_filter.c.orig	Thu May 10 08:53:41 2012
+++ common/argus_filter.c	Thu May 10 08:58:53 2012
@@ -889,14 +889,14 @@
    return (0);
 }
 
-#if !defined(CYGWIN) && !defined(HAVE_SYS_ERRLIST)
+#if !defined(CYGWIN) && defined(HAVE_SYS_ERRLIST)
 static char ArgusErrorString[128];
 #endif
 
 char *
 argus_strerror(int errnum)
 {
-#if !defined(CYGWIN) && !defined(HAVE_SYS_ERRLIST)
+#if !defined(CYGWIN) && defined(HAVE_SYS_ERRLIST)
    extern int sys_nerr;
    extern char *sys_errlist[];
 
