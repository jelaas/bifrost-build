--- block/Makefile.objs~	Fri Feb 15 23:05:35 2013
+++ block/Makefile.objs	Fri Mar  8 11:15:53 2013
@@ -4,7 +4,6 @@
 block-obj-y += qed-check.o
 block-obj-y += parallels.o blkdebug.o blkverify.o
 block-obj-$(CONFIG_WIN32) += raw-win32.o win32-aio.o
-block-obj-$(CONFIG_POSIX) += raw-posix.o
 block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 
 ifeq ($(CONFIG_POSIX),y)
