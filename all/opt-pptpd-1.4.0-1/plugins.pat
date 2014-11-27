--- Makefile.in~	Wed Oct 23 09:02:37 2013
+++ Makefile.in	Thu Nov 27 15:15:42 2014
@@ -250,7 +250,6 @@
 Makefile.uClinux config.embed.h version reconf \
 tools/pptp-portslave tools/vpnstats tools/vpnstats.pl tools/vpnuser \
 pptpd.init pptpd.spec makepackage \
-plugins/Makefile plugins/*.h plugins/*.c \
 debian/README.debian debian/changelog debian/conffiles debian/config \
 debian/control debian/copyright debian/dirs debian/docs \
 debian/examples debian/pptpd-options debian/pptpd.conf \
@@ -272,7 +271,7 @@
 pptpd_LDADD = $(XTRALIBS_MGR)
 pptpctrl_LDADD = $(XTRALIBS_CTRL)
 bcrelay_SOURCES = bcrelay.c defaults.h our_syslog.h our_getopt.h
-subdirs = plugins
+subdirs = 
 all: config.h
 	$(MAKE) $(AM_MAKEFLAGS) all-am
 
