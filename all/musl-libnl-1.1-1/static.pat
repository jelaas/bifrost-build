--- libnl-1.1/lib/Makefile	Mon Jan 14 15:48:45 2008
+++ libnl-1.1.bifrost/lib/Makefile	Wed Feb  9 11:34:51 2011
@@ -32,7 +32,7 @@
 
 DEPS     := $(CIN:%.c=%.d)
 OBJ      := $(CIN:%.c=%.o)
-CFLAGS   += -fPIC
+# CFLAGS   += -fPIC
 OUT_SLIB := $(PACKAGE_NAME).so.$(PACKAGE_VERSION)
 LN_SLIB  := $(PACKAGE_NAME).so
 LN1_SLIB := $(LN_SLIB).1
@@ -47,12 +47,7 @@
 	$(MAKE) $(OUT_SLIB)
 
 $(OUT_SLIB): ../Makefile.opts $(OBJ)
-	@echo "  LD $(OUT_SLIB)"; \
-	$(CC) -shared -Wl,-soname,libnl.so.1 -o $(OUT_SLIB) $(OBJ) $(LIBNL_LIB) -lc
-	@echo "  LN $(OUT_SLIB) $(LN1_SLIB)"; \
-	rm -f $(LN1_SLIB) ; $(LN) -s $(OUT_SLIB) $(LN1_SLIB)
-	@echo "  LN $(LN1_SLIB) $(LN_SLIB)"; \
-	rm -f $(LN_SLIB) ; $(LN) -s $(LN1_SLIB) $(LN_SLIB)
+	ar cr libnl.a $(OBJ)
 
 clean:
 	@echo "  CLEAN lib"; \
@@ -65,11 +60,7 @@
 
 install:
 	mkdir -p $(DESTDIR)$(libdir)/
-	install -m 0644 $(OUT_SLIB) $(DESTDIR)$(libdir)
-	rm -f $(DESTDIR)$(libdir)/$(LN1_SLIB)
-	$(LN) -s $(OUT_SLIB) $(DESTDIR)$(libdir)/$(LN1_SLIB)
-	rm -f $(DESTDIR)$(libdir)/$(LN_SLIB)
-	$(LN) -s $(LN1_SLIB) $(DESTDIR)$(libdir)/$(LN_SLIB)
+	install -m 0644 libnl.a $(DESTDIR)$(libdir)
 
 $(DEPS): ../Makefile.opts
 
--- libnl-1.1/src/Makefile	Mon Jan 14 15:48:45 2008
+++ libnl-1.1.bifrost/src/Makefile	Wed Feb  9 11:37:23 2011
@@ -13,7 +13,7 @@
     include ../Makefile.opts
 endif
 
-LDFLAGS	+= -L../lib -lnl utils.o
+LDFLAGS	+= -L../lib utils.o ../lib/libnl.a -lm
 CIN 	:= $(wildcard nl-*.c) $(wildcard genl-*.c) $(wildcard nf-*.c)
 TOOLS	:= $(CIN:%.c=%)
 
--- libnl-1.1/tests/Makefile	Mon Jan 14 15:48:45 2008
+++ libnl-1.1.bifrost/tests/Makefile	Wed Feb  9 11:25:21 2011
@@ -13,7 +13,7 @@
     include ../Makefile.opts
 endif
 
-LDFLAGS	+= -L../lib -lnl ../src/utils.o
+LDFLAGS	+= -L../lib ../src/utils.o ../lib/libnl.a -lm
 CIN 	:= $(wildcard test-*.c)
 TOOLS	:= $(CIN:%.c=%)
 
