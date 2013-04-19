--- bfd/Makefile.in.orig	2010-05-09 09:15:22.591612705 +0200
+++ bfd/Makefile.in	2010-05-09 09:15:43.371609115 +0200
@@ -320,7 +320,7 @@
 # RELEASE=y
 INCDIR = $(srcdir)/../include
 CSEARCH = -I. -I$(srcdir) -I$(INCDIR)
-SUBDIRS = doc po
+SUBDIRS = 
 bfddocdir = doc
 libbfd_la_LDFLAGS = $(am__append_1) -release `cat libtool-soversion` \
 	@SHARED_LDFLAGS@ $(am__empty)
