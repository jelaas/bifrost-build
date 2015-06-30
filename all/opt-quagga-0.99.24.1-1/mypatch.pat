--- vtysh/Makefile.in.orig	Thu Mar 12 09:36:03 2015
+++ vtysh/Makefile.in	Thu Mar 12 09:36:51 2015
@@ -253,7 +253,7 @@
 LIBM = @LIBM@
 LIBOBJS = @LIBOBJS@
 LIBPAM = @LIBPAM@
-LIBREADLINE = @LIBREADLINE@
+LIBREADLINE = -lreadline -lncurses
 LIBS = @LIBS@ @CURSES@ @LIBPAM@
 LIBTOOL = @LIBTOOL@
 LIB_REGEX = @LIB_REGEX@
@@ -375,7 +375,7 @@
 nodist_vtysh_SOURCES = vtysh_cmd.c
 CLEANFILES = vtysh_cmd.c
 noinst_HEADERS = vtysh.h vtysh_user.h
-vtysh_LDADD = ../lib/libzebra.la @LIBCAP@ @LIBREADLINE@
+vtysh_LDADD = ../lib/libzebra.la @LIBCAP@ -lreadline -lncurses
 examplesdir = $(exampledir)
 dist_examples_DATA = vtysh.conf.sample
 EXTRA_DIST = extract.pl
