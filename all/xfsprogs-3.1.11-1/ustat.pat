--- libxfs/linux.c.orig	Thu Nov 14 11:11:40 2013
+++ libxfs/linux.c	Thu Nov 14 13:51:42 2013
@@ -46,15 +46,38 @@
 
 #define PROC_MOUNTED	"/proc/mounts"
 
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <sys/syscall.h>
+
+struct ustat
+{
+	int32_t f_tfree;/* Number of free blocks.  */
+	ino_t f_tinode;/* Number of free inodes.  */
+	char f_fname[6];
+	char f_fpack[6];
+};
+
+
+int ustat(dev_t dev, struct ustat *ust)
+{
+	return syscall(SYS_ustat,(unsigned)dev, ust);
+}
+
+
 int
 platform_check_ismounted(char *name, char *block, struct stat64 *s, int verbose)
 {
 	/* Pad ust; pre-2.6.28 linux copies out too much in 32bit compat mode */
 	struct ustat	ust[2];
-	struct stat64	st;
+	struct stat	st;
 
 	if (!s) {
-		if (stat64(block, &st) < 0)
+		if (stat(block, &st) < 0)
 			return 0;
 		if ((st.st_mode & S_IFMT) != S_IFBLK)
 			return 0;
