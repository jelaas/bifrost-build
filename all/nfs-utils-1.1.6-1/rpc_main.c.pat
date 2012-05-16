--- tools/rpcgen/rpc_main.c~	Mon Apr 20 17:32:50 2009
+++ tools/rpcgen/rpc_main.c	Wed May 16 12:27:50 2012
@@ -545,13 +545,6 @@
 	  timerflag = 1;
 	}
 
-#ifndef linux
-	if( !tirpcflag && inetdflag )
-	  f_print(fout, "#include <sys/ttycom.h>/* TIOCNOTTY */\n");
-#else
-	if( !tirpcflag )
-	  f_print(fout, "#include <sys/ttycom.h>/* TIOCNOTTY */\n");
-#endif
 	if( Cflag && (inetdflag || pmflag ) ) {
 	  f_print(fout, "#ifdef __cplusplus\n");
 	  f_print(fout, "#include <sysent.h> /* getdtablesize, open */\n"); 
