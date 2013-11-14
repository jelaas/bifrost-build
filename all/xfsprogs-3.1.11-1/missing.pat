--- libdisk/xvm.h~	Thu Nov 14 14:03:46 2013
+++ libdisk/xvm.h	Thu Nov 14 14:10:05 2013
@@ -16,6 +16,8 @@
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <sys/types.h>
+
 #define _DIOC_(x)        (('d'<<8) | x)
 #define DIOCGETVOLDEV    _DIOC_(36) /* subvolume devices */
 #define DIOCGETVOLSTRIPE _DIOC_(47) /* subvolume stripe info */
--- libdisk/evms.h~	Thu Nov 14 14:03:46 2013
+++ libdisk/evms.h	Thu Nov 14 14:10:56 2013
@@ -16,6 +16,8 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <sys/types.h>
+
 #define EVMS_MAJOR			117
 #define EVMS_GET_VOL_STRIPE_INFO	\
 		_IOR(EVMS_MAJOR, 0xF0, struct evms_vol_stripe_info_s)
--- libdisk/evms.c.orig	Thu Nov 14 14:03:44 2013
+++ libdisk/evms.c	Thu Nov 14 14:12:15 2013
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 #include <sys/sysmacros.h>
 #include <disk/volume.h>
+#include <sys/stat.h>
 #include "evms.h"
 
 int
@@ -41,7 +42,7 @@
 	int		*sunit,
 	int		*swidth,
 	int		*sectalign,
-	struct stat64	*sb)
+	struct stat	*sb)
 {
 	if (mnt_is_evms_subvol(sb->st_rdev)) {
 		evms_vol_stripe_info_t	info;
--- fsr/xfs_fsr.c~	Thu Nov 14 14:03:45 2013
+++ fsr/xfs_fsr.c	Thu Nov 14 14:15:52 2013
@@ -37,6 +37,7 @@
 #include <sys/statvfs.h>
 #include <sys/xattr.h>
 
+#include <paths.h>
 
 #ifndef XFS_XFLAG_NODEFRAG
 #define XFS_XFLAG_NODEFRAG 0x00002000 /* src dependancy, remove later */
