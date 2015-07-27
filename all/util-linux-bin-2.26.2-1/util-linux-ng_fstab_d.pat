--- mount/fstab.c.orig	2010-05-20 13:20:21.467612720 +0200
+++ mount/fstab.c	2010-05-26 16:10:43.296611069 +0200
@@ -12,6 +12,8 @@
 #include <sys/time.h>
 #include <time.h>
 #include <mntent.h>
+#include <sys/types.h>
+#include <dirent.h>
 #include "mount_mntent.h"
 #include "fstab.h"
 #include "sundries.h"
@@ -196,9 +198,39 @@
 		int errsv = errno;
 		error(_("warning: can't open %s: %s"),
 		      _PATH_MNTTAB, strerror (errsv));
-		return;
+	} else
+	  read_mntentchn(mfp, fnam, mc);
+
+	/* JEL */
+	{
+	  DIR *dir;
+	  struct dirent *ent;
+	  char dirname[256];
+	  char tabnam[256], *p;
+	  
+	  sprintf(dirname, "%s.d", _PATH_MNTTAB);
+	  dir = opendir(dirname);
+	  if(dir) {
+	    while( (ent = readdir(dir)) ) {
+	      if( (p=strchr(ent->d_name, '.')) ) {
+		if(!strcmp(p, ".fstab")) {
+
+		  sprintf(tabnam, "%s/%s", dirname, ent->d_name);
+
+		  mfp = my_setmntent (tabnam, "r");
+		  if (mfp == NULL || mfp->mntent_fp == NULL) {
+		    int errsv = errno;
+		    error(_("warning: can't open %s: %s"),
+			  tabnam, strerror (errsv));
+		  } else
+		    read_mntentchn(mfp, tabnam, mc);
+
+		}
+	      }
+	    }
+	    closedir(dir);
+	  }
 	}
-	read_mntentchn(mfp, fnam, mc);
 }
 
 
