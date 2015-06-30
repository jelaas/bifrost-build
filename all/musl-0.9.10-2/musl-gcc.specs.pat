--- opt/musl/lib/musl-gcc.specs.orig	Fri Jun  7 12:24:32 2013
+++ opt/musl/lib/musl-gcc.specs	Fri Jun  7 12:26:19 2013
@@ -1,22 +1,22 @@
 %rename cpp_options old_cpp_options
 
 *cpp_options:
--nostdinc -isystem /opt/musl/include %(old_cpp_options)
+-nostdinc -isystem /opt/musl/include -isystem /usr/gcc/include %(old_cpp_options)
 
 *cc1:
-%(cc1_cpu) -nostdinc -isystem /opt/musl/include 
+%(cc1_cpu) -nostdinc -isystem /opt/musl/include -isystem /usr/gcc/include
 
 *link_libgcc:
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
 -dynamic-linker /lib/ld-musl-i386.so.1 -nostdlib %{shared:-shared} %{static:-static} %{rdynamic:-export-dynamic}
