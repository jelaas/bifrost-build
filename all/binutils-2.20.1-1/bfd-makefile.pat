--- buildit/bfd/Makefile~	2010-05-08 22:33:50.628608570 +0200
+++ buildit/bfd/Makefile	2010-05-08 23:45:48.126608931 +0200
@@ -320,7 +320,7 @@
 # RELEASE=y
 INCDIR = $(srcdir)/../include
 CSEARCH = -I. -I$(srcdir) -I$(INCDIR)
-SUBDIRS = doc po
+SUBDIRS =
 bfddocdir = doc
 libbfd_la_LDFLAGS = $(am__append_1) -release `cat libtool-soversion` \
 	 $(am__empty)
