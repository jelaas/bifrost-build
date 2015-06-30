--- tests/create/Makefile.orig	Mon May 24 06:12:37 2010
+++ tests/create/Makefile	Mon May 24 06:13:57 2010
@@ -580,7 +580,7 @@
 all:: kdb5_mkdums
 
 kdb5_mkdums: kdb5_mkdums.o $(KDB5_DEPLIBS) $(KRB5_BASE_DEPLIBS)
-	$(CC_LINK) -o kdb5_mkdums kdb5_mkdums.o $(KDB5_DEP_LIBS) $(KDB5_LIBS) $(KRB5_BASE_LIBS)
+	$(CC_LINK) -o kdb5_mkdums kdb5_mkdums.o $(KDB5_DEP_LIBS) $(KDB5_LIBS) $(KRB5_BASE_LIBS) -lkadm5srv_mit -lgssapi_krb5 -lkrb5 -lk5crypto
 
 all:: kdb5_mkdums
 
