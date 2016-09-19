--- builtins/echo.def.orig	2016-09-17 12:56:23.000000000 +0200
+++ builtins/echo.def	2016-09-17 13:00:57.000000000 +0200
@@ -173,8 +173,18 @@
 	      for (s = temp; len > 0; len--)
 		putchar (*s++);
 	    }
-	  else	    
+          else        {
+            /* make most writes to procfs work */
+            char temp2[24];
+            if(display_return && (list->next == NULL) && ((len=strlen(temp)) < (sizeof(temp2)-1)) && (i == 0)) {
+              strcpy(temp2, temp);
+              temp2[len] = '\n';
+              temp2[len+1] = 0;
+              printf("%s", temp2);
+              goto out;
+            }
 	    printf ("%s", temp);
+	    }
 #if defined (SunOS5)
 	  fflush (stdout);	/* Fix for bug in SunOS 5.5 printf(3) */
 #endif
@@ -195,6 +205,6 @@
 
   if (display_return)
     putchar ('\n');
-
+out:
   return (sh_chkwrite (EXECUTION_SUCCESS));
 }
