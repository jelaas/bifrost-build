--- builtins/echo.def.orig	2013-05-06 11:24:14.008077510 +0200
+++ builtins/echo.def	2013-05-06 11:24:21.752077478 +0200
@@ -172,8 +172,18 @@
 	      for (s = temp; len > 0; len--)
 		putchar (*s++);
 	    }
-	  else	    
+	  else	{
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
+          }
 #if defined (SunOS5)
 	  fflush (stdout);	/* Fix for bug in SunOS 5.5 printf(3) */
 #endif
@@ -192,7 +202,7 @@
 
   if (display_return)
     putchar ('\n');
-
+out:
   terminate_immediately--;
   return (sh_chkwrite (EXECUTION_SUCCESS));
 }
