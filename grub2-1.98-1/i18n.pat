--- include/grub/i18n.h~	Sat Mar  6 20:51:37 2010
+++ include/grub/i18n.h	Sun Sep  5 12:52:08 2010
@@ -25,7 +25,7 @@
 extern const char *(*EXPORT_VAR(grub_gettext)) (const char *s);
 
 /* NLS can be disabled through the configure --disable-nls option.  */
-#if ENABLE_NLS
+#ifdef ENABLE_NLS
 
 # ifdef GRUB_UTIL
 
