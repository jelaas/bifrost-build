--- block/raw-posix.c.orig	2013-03-11 16:00:28.648867194 +0100
+++ block/raw-posix.c	2013-03-11 16:20:18.416225664 +0100
@@ -52,7 +52,6 @@
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/param.h>
-#include <linux/cdrom.h>
 #include <linux/fd.h>
 #include <linux/fs.h>
 #endif
@@ -1674,7 +1673,7 @@
     }
 
     /* Attempt to detect via a CDROM specific ioctl */
-    ret = ioctl(fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
+    return 0;
     if (ret >= 0)
         prio = 100;
 
@@ -1689,9 +1688,6 @@
     BDRVRawState *s = bs->opaque;
     int ret;
 
-    ret = ioctl(s->fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
-    if (ret == CDS_DISC_OK)
-        return 1;
     return 0;
 }
 
@@ -1699,26 +1695,12 @@
 {
     BDRVRawState *s = bs->opaque;
 
-    if (eject_flag) {
-        if (ioctl(s->fd, CDROMEJECT, NULL) < 0)
-            perror("CDROMEJECT");
-    } else {
-        if (ioctl(s->fd, CDROMCLOSETRAY, NULL) < 0)
-            perror("CDROMEJECT");
-    }
 }
 
 static void cdrom_lock_medium(BlockDriverState *bs, bool locked)
 {
     BDRVRawState *s = bs->opaque;
 
-    if (ioctl(s->fd, CDROM_LOCKDOOR, locked) < 0) {
-        /*
-         * Note: an error can happen if the distribution automatically
-         * mounts the CD-ROM
-         */
-        /* perror("CDROM_LOCKDOOR"); */
-    }
 }
 
 static BlockDriver bdrv_host_cdrom = {
@@ -1832,15 +1814,6 @@
 {
     BDRVRawState *s = bs->opaque;
 
-    if (s->fd < 0)
-        return;
-    if (ioctl(s->fd, (locked ? CDIOCPREVENT : CDIOCALLOW)) < 0) {
-        /*
-         * Note: an error can happen if the distribution automatically
-         * mounts the CD-ROM
-         */
-        /* perror("CDROM_LOCKDOOR"); */
-    }
 }
 
 static BlockDriver bdrv_host_cdrom = {
