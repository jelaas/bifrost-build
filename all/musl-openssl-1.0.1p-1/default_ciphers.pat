--- ssl/ssl.h~	Thu Mar 19 14:37:10 2015
+++ ssl/ssl.h	Fri Mar 20 09:54:44 2015
@@ -334,7 +334,8 @@
  * The following cipher list is used by default. It also is substituted when
  * an application-defined cipher list string starts with 'DEFAULT'.
  */
-# define SSL_DEFAULT_CIPHER_LIST "ALL:!EXPORT:!aNULL:!eNULL:!SSLv2"
+# define SSL_DEFAULT_CIPHER_LIST "ALL:!EXPORT:!aNULL:!eNULL:!SSLv2:!RC4:!MD5"
+
 /*
  * As of OpenSSL 1.0.0, ssl_create_cipher_list() in ssl/ssl_ciph.c always
  * starts with a reasonable order, and all we have to do for DEFAULT is
