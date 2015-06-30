--- ext/Net-SSLeay/inc/Module/Install/PRIVATE/Net/SSLeay.pm.orig	Sun Mar 17 16:05:08 2013
+++ ext/Net-SSLeay/inc/Module/Install/PRIVATE/Net/SSLeay.pm	Sun Mar 17 16:05:55 2013
@@ -46,15 +46,6 @@
 
     $self->makemaker_args( CCCDLFLAGS => $opts->{cccdlflags} );
 
-    if ( $self->prompt(
-            "Do you want to run external tests?\n".
-            "These tests *will* *fail* if you do not have network connectivity.",
-            'n',
-    ) =~ /^y/i ) {
-        $self->tests('t/*/*.t t/*/*/*.t');
-    } else {
-        $self->tests('t/local/*.t t/handle/local/*.t');
-    }
 }
 
 sub ssleay_get_build_opts {
--- ext/Net-SSLeay/SSLeay.xs.orig	Sun Mar 17 16:07:54 2013
+++ ext/Net-SSLeay/SSLeay.xs	Sun Mar 17 16:08:34 2013
@@ -106,9 +106,6 @@
 #endif
 #include <openssl/md4.h>
 #include <openssl/md5.h>     /* openssl-SNAP-20020227 does not automatically include this */
-#if OPENSSL_VERSION_NUMBER >= 0x00905000L
-#include <openssl/ripemd.h>
-#endif
 #include <openssl/x509.h>
 #include <openssl/x509v3.h>
 #include <openssl/engine.h>
@@ -1801,7 +1798,7 @@
 	  XSRETURN_UNDEF;
      }
 
-#if OPENSSL_VERSION_NUMBER >= 0x00905000L
+#if 0
 
 void 
 RIPEMD160(data)
