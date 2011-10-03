--- slave/Makefile.orig	Mon May 24 06:04:56 2010
+++ slave/Makefile	Mon May 24 06:05:35 2010
@@ -594,10 +594,10 @@
 	$(CC_LINK) -o kprop $(CLIENTOBJS) $(KRB5_BASE_LIBS) -lutil
 
 kpropd: $(SERVEROBJS) $(KDB5_DEPLIB) $(KADMCLNT_DEPLIBS) $(KRB5_BASE_DEPLIBS) $(APPUTILS_DEPLIB)
-	$(CC_LINK) -o kpropd $(SERVEROBJS) $(KDB5_LIB) $(KADMCLNT_LIBS) $(KRB5_BASE_LIBS) $(APPUTILS_LIB) -lutil
+	$(CC_LINK) -o kpropd $(SERVEROBJS) $(KDB5_LIB) $(KADMCLNT_LIBS) $(KRB5_BASE_LIBS) $(APPUTILS_LIB) -lutil -lkadm5srv_mit -lgssapi_krb5 -lkrb5 -lk5crypto
 
 kproplog: $(LOGOBJS)
-	$(CC_LINK) -o kproplog $(LOGOBJS) $(KADMSRV_LIBS) $(KRB5_BASE_LIBS)
+	$(CC_LINK) -o kproplog $(LOGOBJS) $(KADMSRV_LIBS) $(KRB5_BASE_LIBS) -lkadm5srv_mit -lgssapi_krb5 -lkrb5 -lk5crypto
 
 install::
 	for f in kprop kpropd kproplog; do \
