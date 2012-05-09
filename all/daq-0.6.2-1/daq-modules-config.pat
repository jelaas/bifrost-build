--- bin/daq-modules-config~	Wed May  9 13:33:08 2012
+++ bin/daq-modules-config	Wed May  9 13:45:50 2012
@@ -8,7 +8,7 @@
 prefix=/usr
 exec_prefix=${prefix}
 LIBDIR=${exec_prefix}/lib
-STATIC_LIBS=" -lsfbpf -lpcap -lsfbpf -lnfnetlink -lnetfilter_queue -lsfbpf -lpcap -L/usr/lib -ldnet"
+STATIC_LIBS=" -lsfbpf -lpcap -lsfbpf -lnetfilter_queue -lnfnetlink -lsfbpf -lpcap -L/usr/lib -ldnet"
 
 static=0
 show_libs=0
