--- opt/musl/lib/musl-gcc.specs.orig	Fri Sep 21 07:04:50 2012
+++ opt/musl/lib/musl-gcc.specs	Fri Sep 21 07:12:34 2012
@@ -10,13 +10,13 @@
 -L/opt/musl/lib -L .%s
 
 *libgcc:
-libgcc.a%s %:if-exists(libgcc_eh.a%s)
+/usr/gcc/lib/libgcc.a%s %:if-exists(/usr/gcc/lib/libgcc_eh.a%s)
 
 *startfile:
-%{!shared: /opt/musl/lib/%{pie:S}crt1.o} /opt/musl/lib/crti.o %{shared|pie:crtbeginS.o%s;:crtbegin.o%s}
+%{!shared: /opt/musl/lib/%{pie:S}crt1.o} /opt/musl/lib/crti.o %{shared|pie:crtbeginS.o%s;:/usr/gcc/lib/crtbegin.o%s}
 
 *endfile:
-%{shared|pie:crtendS.o%s;:crtend.o%s} /opt/musl/lib/crtn.o
+%{shared|pie:crtendS.o%s;:/usr/gcc/lib/crtend.o%s} /opt/musl/lib/crtn.o
 
 *link:
 -dynamic-linker /lib/ld-musl-x86_64.so.1 -nostdlib %{shared:-shared} %{static:-static} %{rdynamic:-export-dynamic}
