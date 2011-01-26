--- Makefile.orig	Wed Jan 26 10:24:52 2011
+++ Makefile	Wed Jan 26 10:26:35 2011
@@ -36,25 +36,22 @@
 	numamon.c shm.c stream_lib.c stream_main.c syscall.c util.c mt.c \
 	clearcache.c test/*.c
 
-prefix := /usr
+prefix := ${DESTDIR}/usr
 libdir := ${prefix}/$(shell ./getlibdir)
 docdir := ${prefix}/share/doc
 
-all: numactl migratepages migspeed libnuma.so numademo numamon memhog \
-     test/tshared stream test/mynode test/pagesize test/ftok test/prefered \
-     test/randmap test/nodemap test/distance test/tbitmap test/move_pages \
-     test/mbind_mig_pages test/migrate_pages libnuma.a
+all: numactl migratepages migspeed libnuma.so numademo numamon memhog
 
-numactl: numactl.o util.o shm.o bitops.o libnuma.so
+numactl: numactl.o util.o shm.o bitops.o libnuma.a
 
-migratepages: migratepages.c util.o bitops.o libnuma.so
+migratepages: migratepages.c util.o bitops.o libnuma.a
 
 migspeed: LDLIBS += -lrt
-migspeed: migspeed.o util.o libnuma.so
+migspeed: migspeed.o util.o libnuma.a
 
 util.o: util.c
 
-memhog: util.o memhog.o libnuma.so
+memhog: util.o memhog.o libnuma.a
 
 numactl.o: numactl.c
 
@@ -64,7 +61,7 @@
 stream_lib.o: CFLAGS += ${BENCH_CFLAGS}
 mt.o: CFLAGS += ${BENCH_CFLAGS} 
 mt.o: mt.c
-numademo: numademo.o stream_lib.o mt.o libnuma.so clearcache.o
+numademo: numademo.o stream_lib.o mt.o libnuma.a clearcache.o
 
 test_numademo: numademo
 	LD_LIBRARY_PATH=$$(pwd) ./numademo -t -e 10M
