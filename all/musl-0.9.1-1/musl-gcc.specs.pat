--- opt/musl/lib/musl-gcc.specs.orig	Fri Sep 21 10:34:23 2012
+++ opt/musl/lib/musl-gcc.specs	Fri Sep 21 10:35:15 2012
@@ -10,13 +10,13 @@
 -L/opt/musl/lib
 
 *libgcc:
-libgcc.a%s %:if-exists(libgcc_eh.a%s)
+/usr/gcc/lib/libgcc.a%s %:if-exists(/usr/gcc/lib/libgcc_eh.a%s)
 
 *startfile:
-%{!shared: /opt/musl/lib/%{pie:S}crt1.o} /opt/musl/lib/crti.o %{shared|pie:crtbeginS.o%s;:crtbegin.o%s}
+%{!shared: /opt/musl/lib/%{pie:S}crt1.o} /opt/musl/lib/crti.o %{shared|pie:crtbeginS.o%s;:/usr/gcc/lib/crtbegin.o%s}
 
 *endfile:
-%{shared|pie:crtendS.o%s;:crtend.o%s} /opt/musl/lib/crtn.o
+%{shared|pie:crtendS.o%s;:/usr/gcc/lib/crtend.o%s} /opt/musl/lib/crtn.o
 
 %rename link old_link
 
