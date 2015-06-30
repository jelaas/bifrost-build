--- disk-utils/fsck.minix.c.orig	Wed Feb 27 20:31:20 2013
+++ disk-utils/fsck.minix.c	Wed Feb 27 20:32:59 2013
@@ -261,7 +261,9 @@
 	printf(def ? _("%s (y/n)? ") : _("%s (n/y)? "), string);
 	fflush(stdout);
 	ignore_result( fgets(input, YESNO_LENGTH, stdin) );
-	resp = rpmatch(input);
+	resp = -1;
+	if(input[0] == 'y') resp = 1;
+	if(input[0] == 'n') resp = 0;
 	switch (resp) {
 	case -1:
 		/* def = def */
