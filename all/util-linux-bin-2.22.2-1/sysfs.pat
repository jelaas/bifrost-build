--- lib/sysfs.c.orig	Wed Feb 27 19:01:00 2013
+++ lib/sysfs.c	Wed Feb 27 19:06:29 2013
@@ -233,28 +233,14 @@
 DIR *sysfs_opendir(struct sysfs_cxt *cxt, const char *attr)
 {
 	DIR *dir;
-	int fd = -1;
+	char fn[PATH_MAX];
 
 	if (attr)
-		fd = sysfs_open(cxt, attr);
+		snprintf(fn, sizeof(fn), "%s/%s", cxt->dir_path, attr);
+	else
+		snprintf(fn, sizeof(fn), "%s", cxt->dir_path);
 
-	else if (cxt->dir_fd >= 0)
-		/* request to open root of device in sysfs (/sys/block/<dev>)
-		 * -- we cannot use cxt->sysfs_fd directly, because closedir()
-		 * will close this our persistent file descriptor.
-		 */
-		fd = dup(cxt->dir_fd);
-
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
 
@@ -282,7 +268,7 @@
 	return d;
 }
 
-int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_name)
+int sysfs_is_partition_dirent(struct sysfs_cxt *cxt, DIR *dir, struct dirent *d, const char *parent_name)
 {
 	char path[256];
 
@@ -316,9 +302,9 @@
 	}
 
 	/* Cannot use /partition file, not supported on old sysfs */
-	snprintf(path, sizeof(path), "%s/start", d->d_name);
+	snprintf(path, sizeof(path), "%s/%s/start", cxt->dir_path, d->d_name);
 
-	return faccessat(dirfd(dir), path, R_OK, 0) == 0;
+	return access(path, R_OK) == 0;
 }
 
 /*
@@ -342,7 +328,7 @@
 	while ((d = xreaddir(dir))) {
 		int n, maj, min;
 
-		if (!sysfs_is_partition_dirent(dir, d, NULL))
+		if (!sysfs_is_partition_dirent(cxt, dir, d, NULL))
 			continue;
 
 		snprintf(path, sizeof(path), "%s/partition", d->d_name);
@@ -446,7 +432,7 @@
 		return 0;
 
 	while ((d = xreaddir(dir))) {
-		if (sysfs_is_partition_dirent(dir, d, devname))
+		if (sysfs_is_partition_dirent(cxt, dir, d, devname))
 			r++;
 	}
 
--- include/sysfs.h.orig	Wed Feb 27 19:13:37 2013
+++ include/sysfs.h	Wed Feb 27 19:13:56 2013
@@ -60,7 +60,7 @@
 extern dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno);
 extern char *sysfs_get_slave(struct sysfs_cxt *cxt);
 
-extern int sysfs_is_partition_dirent(DIR *dir, struct dirent *d,
+extern int sysfs_is_partition_dirent(struct sysfs_cxt *cxt, DIR *dir, struct dirent *d,
 			const char *parent_name);
 
 extern int sysfs_devno_to_wholedisk(dev_t dev, char *diskname,
