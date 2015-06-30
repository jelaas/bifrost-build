--- ./lib/sysfs.c.orig	Wed Feb  8 12:44:32 2012
+++ ./lib/sysfs.c	Wed Feb  8 13:26:44 2012
@@ -227,27 +227,14 @@
 DIR *sysfs_opendir(struct sysfs_cxt *cxt, const char *attr)
 {
 	DIR *dir;
-	int fd;
+	char fn[PATH_MAX];
 
-	if (attr)
-		fd = sysfs_open(cxt, attr);
+	if(attr)
+		snprintf(fn, sizeof(fn), "%s/%s", cxt->dir_path, attr);
 	else
-		/* request to open root of device in sysfs (/sys/block/<dev>)
-		 * -- we cannot use cxt->sysfs_fd directly, because closedir()
-		 * will close this our persistent file descriptor.
-		 */
-		fd = dup(cxt->dir_fd);
+		snprintf(fn, sizeof(fn), "%s", cxt->dir_path);
 
-	if (fd < 0)
-		return NULL;
-
-	dir = fdopendir(fd);
-	if (!dir) {
-		close(fd);
-		return NULL;
-	}
-	if (!attr)
-		 rewinddir(dir);
+	dir = opendir(fn);
 	return dir;
 }
 
@@ -275,7 +262,7 @@
 	return d;
 }
 
-int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_name)
+int sysfs_is_partition_dirent(struct sysfs_cxt *cxt, DIR *dir, struct dirent *d, const char *parent_name)
 {
 	char path[256];
 
@@ -287,9 +274,9 @@
 		return 0;
 
 	/* Cannot use /partition file, not supported on old sysfs */
-	snprintf(path, sizeof(path), "%s/start", d->d_name);
+	snprintf(path, sizeof(path), "%s/%s/start", cxt->dir_path, d->d_name);
 
-	return faccessat(dirfd(dir), path, R_OK, 0) == 0;
+	return access(path, R_OK) == 0;
 }
 
 int sysfs_scanf(struct sysfs_cxt *cxt,  const char *attr, const char *fmt, ...)
@@ -376,7 +363,7 @@
 		return 0;
 
 	while ((d = xreaddir(dir))) {
-		if (sysfs_is_partition_dirent(dir, d, devname))
+		if (sysfs_is_partition_dirent(cxt, dir, d, devname))
 			r++;
 	}
 
