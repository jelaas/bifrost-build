--- config.layout.orig	Thu Nov 25 07:51:20 2010
+++ config.layout	Thu Nov 25 07:51:48 2010
@@ -28,8 +28,8 @@
     cgidir:        ${datadir}/cgi-bin
     includedir:    ${prefix}/include
     localstatedir: ${prefix}
-    runtimedir:    ${localstatedir}/logs
-    logfiledir:    ${localstatedir}/logs
+    runtimedir:    ${localstatedir}/run
+    logfiledir:    ${localstatedir}/log
     proxycachedir: ${localstatedir}/proxy
 </Layout>
 
