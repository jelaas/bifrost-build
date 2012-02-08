--- ./include/sysfs.h.orig	Wed Feb  8 13:24:14 2012
+++ ./include/sysfs.h	Wed Feb  8 13:24:32 2012
@@ -58,7 +58,7 @@
 extern int sysfs_count_partitions(struct sysfs_cxt *cxt, const char *devname);
 extern char *sysfs_get_slave(struct sysfs_cxt *cxt);
 
-extern int sysfs_is_partition_dirent(DIR *dir, struct dirent *d,
+extern int sysfs_is_partition_dirent(struct sysfs_cxt *cxt, DIR *dir, struct dirent *d,
 			const char *parent_name);
 
 #endif /* UTIL_LINUX_SYSFS_H */
