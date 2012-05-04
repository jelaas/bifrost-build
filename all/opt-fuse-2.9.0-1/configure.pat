--- configure~	Tue Sep 28 09:23:51 2010
+++ configure	Wed Jan 12 11:51:19 2011
@@ -12452,7 +12452,7 @@
 fi
 
 
-libfuse_libs="-pthread"
+libfuse_libs="-lpthread"
 LIBS=
 { $as_echo "$as_me:$LINENO: checking for library containing dlopen" >&5
 $as_echo_n "checking for library containing dlopen... " >&6; }
--- util/Makefile.in~	Tue Sep 28 09:23:54 2010
+++ util/Makefile.in	Wed Jan 12 11:55:00 2011
@@ -214,7 +214,7 @@
 mount_fuse_SOURCES = mount.fuse.c
 ulockmgr_server_SOURCES = ulockmgr_server.c
 ulockmgr_server_CPPFLAGS = -D_FILE_OFFSET_BITS=64 -D_REENTRANT 
-ulockmgr_server_LDFLAGS = -pthread
+ulockmgr_server_LDFLAGS = -lpthread
 EXTRA_DIST = udev.rules init_script
 all: all-am
 
