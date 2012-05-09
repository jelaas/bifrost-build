--- src/dynamic-plugins/sf_engine/Makefile.am.orig	Wed Jun  8 00:33:11 2011
+++ src/dynamic-plugins/sf_engine/Makefile.am	Wed May  9 12:32:45 2012
@@ -3,11 +3,11 @@
 
 INCLUDES = @INCLUDES@
 
-lib_LTLIBRARIES = libsf_engine.la
+noinst_LIBRARIES = libsf_engine.a
 
 libdir = ${exec_prefix}/lib/snort_dynamicengine
 
-libsf_engine_la_LDFLAGS = -shared -export-dynamic -module @XCCFLAGS@
+# libsf_engine_la_LDFLAGS = -shared -export-dynamic -module @XCCFLAGS@
 
 BUILT_SOURCES = \
 sfhashfcn.c \
@@ -23,7 +23,7 @@
 sf_types.h \
 sf_protocols.h 
 
-nodist_libsf_engine_la_SOURCES = \
+libsf_engine_a_SOURCES = \
 sfhashfcn.c \
 sfhashfcn.h \
 sfghash.c \
@@ -35,9 +35,7 @@
 sf_ip.h \
 snort_debug.h \
 sf_types.h \
-sf_protocols.h 
-
-libsf_engine_la_SOURCES = \
+sf_protocols.h \
 bmh.c \
 bmh.h \
 sf_snort_detection_engine.c \
