--- tests/verify/Makefile.orig	Mon May 24 06:23:49 2010
+++ tests/verify/Makefile	Mon May 24 06:24:22 2010
@@ -581,7 +581,7 @@
 all:: kdb5_verify
 
 kdb5_verify: kdb5_verify.o $(KDB5_DEPLIBS) $(KRB5_BASE_DEPLIBS)
-	$(CC_LINK) -o kdb5_verify kdb5_verify.o $(KDB5_LIBS) $(KDB5_DEP_LIB) $(KRB5_BASE_LIBS)
+	$(CC_LINK) -o kdb5_verify kdb5_verify.o $(KDB5_LIBS) $(KDB5_DEP_LIB) $(KRB5_BASE_LIBS) -lkadm5srv_mit -lgssapi_krb5 -lkrb5 -lk5crypto
 
 install::
 
