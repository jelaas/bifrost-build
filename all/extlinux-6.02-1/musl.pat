--- mk/syslinux.mk.orig	Sun Oct 13 19:59:03 2013
+++ mk/syslinux.mk	Fri Aug 22 13:22:34 2014
@@ -46,7 +46,7 @@
 
 CHMOD	 = chmod
 
-CC	 = gcc
+CC	 = musl-gcc -D__SIZEOF_POINTER__=4
 gcc_ok   = $(shell tmpf=gcc_ok.$$$$.tmp; \
 		   if $(CC) $(GCCOPT) $(1) -c $(topdir)/dummy.c \
 			-o $$tmpf 2>/dev/null ; \
--- com32/lua/etc/Makefile~	Sun Oct 13 19:59:03 2013
+++ com32/lua/etc/Makefile	Fri Aug 22 13:35:11 2014
@@ -7,7 +7,7 @@
 SRC= $(TOP)/src
 TST= $(TOP)/test
 
-CC= gcc
+CC= musl-gcc -D__SIZEOF_POINTER__=4
 CFLAGS= -O2 -Wall -I$(INC) $(MYCFLAGS)
 MYCFLAGS= 
 MYLDFLAGS= -Wl,-E
--- ./gpxe/src/Makefile~	Sun Oct 13 19:59:03 2013
+++ ./gpxe/src/Makefile	Fri Aug 22 13:46:23 2014
@@ -13,7 +13,7 @@
 #
 # Locations of tools
 #
-HOST_CC		:= gcc
+HOST_CC		:= musl-gcc -D__SIZEOF_POINTER__=4
 RM		:= rm -f
 TOUCH		:= touch
 MKDIR		:= mkdir
@@ -21,7 +21,7 @@
 ECHO		:= echo
 PRINTF		:= printf
 PERL		:= /usr/bin/perl
-CC		:= $(CROSS_COMPILE)gcc
+CC		:= $(CROSS_COMPILE)musl-gcc -D__SIZEOF_POINTER__=4
 CPP		:= $(CC) -E
 AS		:= $(CROSS_COMPILE)as
 LD		:= $(CROSS_COMPILE)ld
--- gpxe/src/arch/i386/include/bits/stdint.h.orig	Fri Aug 22 13:59:12 2014
+++ gpxe/src/arch/i386/include/bits/stdint.h	Fri Aug 22 13:59:33 2014
@@ -4,8 +4,6 @@
 FILE_LICENCE ( GPL2_OR_LATER );
 
 typedef __SIZE_TYPE__		size_t;
-typedef signed long		ssize_t;
-typedef signed long		off_t;
 
 typedef unsigned char		uint8_t;
 typedef unsigned short		uint16_t;
@@ -18,6 +16,5 @@
 typedef signed long long	int64_t;
 
 typedef unsigned long		physaddr_t;
-typedef unsigned long		intptr_t;
 
 #endif /* _BITS_STDINT_H */
--- gpxe/src/core/cwuri.c.orig	Fri Aug 22 14:03:02 2014
+++ gpxe/src/core/cwuri.c	Fri Aug 22 14:03:11 2014
@@ -19,6 +19,7 @@
 FILE_LICENCE ( GPL2_OR_LATER );
 
 #include <stddef.h>
+#include <sys/types.h>
 #include <gpxe/uri.h>
 
 /** @file
--- Makefile~	Sun Oct 13 19:59:03 2013
+++ Makefile	Fri Aug 22 14:11:08 2014
@@ -161,7 +161,7 @@
 	mbr/*.bin \
 	core/pxelinux.0 core/lpxelinux.0 \
 	core/isolinux.bin core/isolinux-debug.bin \
-	gpxe/gpxelinux.0 dos/syslinux.com \
+	dos/syslinux.com \
 	win32/syslinux.exe win64/syslinux64.exe \
 	dosutil/*.com dosutil/*.sys \
 	$(MODULES)
@@ -184,7 +184,7 @@
 
 else
 
-BSUBDIRS = codepage com32 lzo core memdisk mbr memdump gpxe sample \
+BSUBDIRS = codepage com32 lzo core memdisk mbr memdump sample \
 	   diag libinstaller dos win32 win64 dosutil txt
 
 ITARGET  =
@@ -198,7 +198,7 @@
 # Things to install in /sbin
 INSTALL_SBIN  = extlinux/extlinux
 # Things to install in /usr/lib/syslinux
-INSTALL_AUX   =	core/pxelinux.0 gpxe/gpxelinux.0 gpxe/gpxelinuxk.0 \
+INSTALL_AUX   =	core/pxelinux.0 gpxe/gpxelinux.0 \
 		core/isolinux.bin core/isolinux-debug.bin \
 		dos/syslinux.com core/lpxelinux.0 \
 		mbr/*.bin $(INSTALLABLE_MODULES)
@@ -213,7 +213,7 @@
 EXTBOOTINSTALL = $(INSTALLABLE_MODULES)
 
 # Things to install in /tftpboot
-NETINSTALLABLE = core/pxelinux.0 gpxe/gpxelinux.0 core/lpxelinux.0 \
+NETINSTALLABLE = core/pxelinux.0 core/lpxelinux.0 \
 		 $(INSTALLABLE_MODULES)
 
 endif # ifdef EFI_BUILD
