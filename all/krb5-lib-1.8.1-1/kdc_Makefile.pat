--- src/kdc/Makefile.orig	Sun May 23 13:33:44 2010
+++ src/kdc/Makefile	Sun May 23 13:46:06 2010
@@ -633,10 +633,10 @@
 kdc5_err.o: kdc5_err.h
 
 krb5kdc: $(OBJS) $(KADMSRV_DEPLIBS) $(KRB5_BASE_DEPLIBS) $(APPUTILS_DEPLIB)
-	$(CC_LINK) -o krb5kdc $(OBJS) $(KADMSRV_LIBS) $(KRB5_BASE_LIBS) $(APPUTILS_LIB)
+	$(CC_LINK) -o krb5kdc $(OBJS) $(KADMSRV_LIBS) $(KRB5_BASE_LIBS) $(APPUTILS_LIB) -lkadm5srv_mit -lgssapi_krb5 -lkrb5 -lk5crypto
 
 rtest: $(RT_OBJS) $(KDB5_DEPLIBS) $(KADM_COMM_DEPLIBS) $(KRB5_BASE_DEPLIBS)
-	$(CC_LINK) -o rtest $(RT_OBJS) $(KDB5_LIBS) $(KADM_COMM_LIBS) $(KRB5_BASE_LIBS)
+	$(CC_LINK) -o rtest $(RT_OBJS) $(KDB5_LIBS) $(KADM_COMM_LIBS) $(KRB5_BASE_LIBS) -lkadm5srv_mit -lgssapi_krb5 -lkrb5 -lk5crypto
 
 check-unix:: rtest
 	KRB5_CONFIG=$(top_srcdir)/config-files/krb5.conf ; export KRB5_CONFIG ; \
