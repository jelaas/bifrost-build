--- ./misc-utils/lsblk.c.orig	Wed Feb  8 13:19:25 2012
+++ ./misc-utils/lsblk.c	Wed Feb  8 13:21:20 2012
@@ -712,7 +712,7 @@
 		err(EXIT_FAILURE, _("failed to open device directory in sysfs"));
 
 	while ((d = xreaddir(dir))) {
-		if (!sysfs_is_partition_dirent(dir, d, cxt->name))
+		if (!sysfs_is_partition_dirent(&cxt->sysfs, dir, d, cxt->name))
 			continue;
 
 		if (set_cxt(&holder, cxt, d->d_name, 1)) {
