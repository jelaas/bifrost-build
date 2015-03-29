--- ./agent/mibgroup/host/hr_system.c~	2008-10-21 23:10:43.000000000 +0200
+++ ./agent/mibgroup/host/hr_system.c	2010-08-24 15:42:07.219962947 +0200
@@ -81,7 +81,7 @@
 #define UTMP_FILE _PATH_UTMP
 #endif
 
-#if defined(UTMP_FILE) && !HAVE_UTMPX_H
+#if !defined(UTMP_FILE) && !HAVE_UTMPX_H
 void            setutent(void);
 void            endutent(void);
 struct utmp    *getutent(void);
@@ -659,7 +659,7 @@
     return total;
 }
 
-#if defined(UTMP_FILE) && !HAVE_UTMPX_H
+#if !defined(UTMP_FILE) && !HAVE_UTMPX_H
 
 static FILE    *utmp_file;
 static struct utmp utmp_rec;
