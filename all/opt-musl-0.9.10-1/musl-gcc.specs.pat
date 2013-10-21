--- opt/dev-x86_32/lib/musl-gcc.specs.orig	Fri Sep 21 07:04:50 2012
+++ opt/dev-x86_32/lib/musl-gcc.specs	Fri Sep 21 07:12:34 2012
@@ -10,13 +10,13 @@
 -L/opt/musl/lib -L .%s
 
 *libgcc:
-libgcc.a%s %:if-exists(libgcc_eh.a%s)
+/usr/gcc/lib/libgcc.a%s %:if-exists(/opt/dev-x86_32/lib/gcc/i586-linux-uclibc/4.6.1/libgcc_eh.a%s)
 
 *startfile:
-%{!shared: /opt/dev-x86_32/lib/%{pie:S}crt1.o} /opt/dev-x86_32/lib/crti.o %{shared|pie:crtbeginS.o%s;:crtbegin.o%s}
+%{!shared: /opt/dev-x86_32/lib/%{pie:S}crt1.o} /opt/dev-x86_32/lib/crti.o %{shared|pie:crtbeginS.o%s;:/opt/dev-x86_32/lib/gcc/i586-linux-uclibc/4.6.1/crtbegin.o%s}
 
 *endfile:
-%{shared|pie:crtendS.o%s;:crtend.o%s} /opt/dev-x86_32/lib/crtn.o
+%{shared|pie:crtendS.o%s;:/opt/dev-x86_32/lib/gcc/i586-linux-uclibc/4.6.1/crtend.o%s} /opt/dev-x86_32/lib/crtn.o
 
 *link:
 -dynamic-linker /lib/ld-musl-i386.so.1 -nostdlib %{shared:-shared} %{static:-static} %{rdynamic:-export-dynamic}
