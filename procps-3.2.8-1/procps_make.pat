--- Makefile.orig	Sat May 29 16:32:51 2010
+++ Makefile	Sat May 29 16:33:21 2010
@@ -77,7 +77,7 @@
 #ldl := -ldl
 #LIBTYPE := -DSHAREDLIB
 #else
-#LIBTYPE := -DSTATICLIB
+LIBTYPE := -DSTATICLIB
 #endif
 
 # Preprocessor flags.
@@ -102,11 +102,11 @@
   -Wstrict-prototypes -Wmissing-prototypes
 # Note that some stuff below is conditional on CFLAGS containing
 # an option that starts with "-g". (-g, -g2, -g3, -ggdb, etc.)
-CFLAGS       := -O2 -s
+CFLAGS       := -Os -march=i586
 ALL_CFLAGS   := $(PKG_CFLAGS) $(CFLAGS)
 
 PKG_LDFLAGS  := -Wl,-warn-common
-LDFLAGS      :=
+LDFLAGS      := -static
 ALL_LDFLAGS  := $(PKG_LDFLAGS) $(LDFLAGS)
 
 ############ Add some extra flags if gcc allows
--- proc/module.mk.orig	Sat May 29 16:36:48 2010
+++ proc/module.mk	Sat May 29 16:37:00 2010
@@ -17,7 +17,7 @@
 # numbers for future use, the ELF soname can be set equal to the
 # file name until some future date when a stable ABI is declared.
 
-SHARED     := 1
+SHARED     := 0
 
 # for lib$(NAME).so and /usr/include/($NAME) and such
 NAME       :=  proc
