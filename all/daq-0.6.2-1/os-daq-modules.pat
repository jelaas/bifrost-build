--- os-daq-modules/Makefile.am.orig	Wed Sep 28 16:02:24 2011
+++ os-daq-modules/Makefile.am	Wed May  9 11:56:59 2012
@@ -15,61 +15,31 @@
 libdaq_static_modules_la_LIBADD =
 
 if BUILD_AFPACKET_MODULE
-    pkglib_LTLIBRARIES += daq_afpacket.la
-    daq_afpacket_la_SOURCES = daq_afpacket.c
-    daq_afpacket_la_CFLAGS = -DBUILDING_SO
-    daq_afpacket_la_LDFLAGS = -module -export-dynamic -avoid-version -shared @XCCFLAGS@
-    daq_afpacket_la_LIBADD = $(top_builddir)/sfbpf/libsfbpf.la
     libdaq_static_modules_la_SOURCES += daq_afpacket.c
     libdaq_static_modules_la_CFLAGS += -DBUILD_AFPACKET_MODULE
 endif
 
 if BUILD_PCAP_MODULE
-    pkglib_LTLIBRARIES += daq_pcap.la
-    daq_pcap_la_SOURCES = daq_pcap.c
-    daq_pcap_la_CFLAGS = -DBUILDING_SO
-    daq_pcap_la_LDFLAGS = -module -export-dynamic -avoid-version -shared @XCCFLAGS@
-    daq_pcap_la_LIBADD = -lpcap
     libdaq_static_modules_la_SOURCES += daq_pcap.c
     libdaq_static_modules_la_CFLAGS += -DBUILD_PCAP_MODULE
 endif
 
 if BUILD_DUMP_MODULE
-    pkglib_LTLIBRARIES += daq_dump.la
-    daq_dump_la_SOURCES = daq_dump.c
-    daq_dump_la_CFLAGS = -DBUILDING_SO
-    daq_dump_la_LDFLAGS = -module -export-dynamic -avoid-version -shared @XCCFLAGS@
-    daq_dump_la_LIBADD = -lpcap
     libdaq_static_modules_la_SOURCES += daq_dump.c
     libdaq_static_modules_la_CFLAGS += -DBUILD_DUMP_MODULE
 endif
 
 if BUILD_IPFW_MODULE
-    pkglib_LTLIBRARIES += daq_ipfw.la
-    daq_ipfw_la_SOURCES = daq_ipfw.c
-    daq_ipfw_la_CFLAGS = -DBUILDING_SO
-    daq_ipfw_la_LDFLAGS = -module -export-dynamic -avoid-version -shared @XCCFLAGS@
-    daq_ipfw_la_LIBADD = $(top_builddir)/sfbpf/libsfbpf.la
     libdaq_static_modules_la_SOURCES += daq_ipfw.c
     libdaq_static_modules_la_CFLAGS += -DBUILD_IPFW_MODULE
 endif
 
 if BUILD_IPQ_MODULE
-    pkglib_LTLIBRARIES += daq_ipq.la
-    daq_ipq_la_SOURCES = daq_ipq.c
-    daq_ipq_la_CFLAGS = -DBUILDING_SO
-    daq_ipq_la_LDFLAGS = -module -export-dynamic -avoid-version -shared @DNET_LDFLAGS@ @XCCFLAGS@
-    daq_ipq_la_LIBADD = -lipq @DNET_LDFLAGS@ $(top_builddir)/sfbpf/libsfbpf.la
     libdaq_static_modules_la_SOURCES += daq_ipq.c
     libdaq_static_modules_la_CFLAGS += -DBUILD_IPQ_MODULE
 endif
 
 if BUILD_NFQ_MODULE
-    pkglib_LTLIBRARIES += daq_nfq.la
-    daq_nfq_la_SOURCES = daq_nfq.c
-    daq_nfq_la_CFLAGS = -DBUILDING_SO
-    daq_nfq_la_LDFLAGS = -module -export-dynamic -avoid-version -shared @DNET_LDFLAGS@ @XCCFLAGS@
-    daq_nfq_la_LIBADD = -lnfnetlink -lnetfilter_queue @DNET_LDFLAGS@ $(top_builddir)/sfbpf/libsfbpf.la
     libdaq_static_modules_la_SOURCES += daq_nfq.c
     libdaq_static_modules_la_CFLAGS += -DBUILD_NFQ_MODULE
 endif
