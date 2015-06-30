diff -ur quagga-0.99.17/vtysh/Makefile.in quagga-0.99.17-patched/vtysh/Makefile.in
--- quagga-0.99.17/vtysh/Makefile.in	2010-08-19 11:43:03.000000000 +0200
+++ quagga-0.99.17-patched/vtysh/Makefile.in	2011-02-16 15:55:37.000000000 +0100
@@ -152,7 +152,7 @@
 LIBM = @LIBM@
 LIBOBJS = @LIBOBJS@
 LIBPAM = @LIBPAM@
-LIBREADLINE = @LIBREADLINE@
+LIBREADLINE = -lreadline -lncurses
 LIBS = @LIBS@ @CURSES@ @LIBPAM@
 LIBTOOL = @LIBTOOL@
 LIB_IPV6 = @LIB_IPV6@
@@ -269,7 +269,7 @@
 nodist_vtysh_SOURCES = vtysh_cmd.c
 CLEANFILES = vtysh_cmd.c
 noinst_HEADERS = vtysh.h vtysh_user.h
-vtysh_LDADD = ../lib/libzebra.la @LIBCAP@ @LIBREADLINE@
+vtysh_LDADD = ../lib/libzebra.la @LIBCAP@ -lreadline -lncurses
 examplesdir = $(exampledir)
 dist_examples_DATA = vtysh.conf.sample
 EXTRA_DIST = extract.pl
