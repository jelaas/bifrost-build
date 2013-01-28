--- configure.orig	Mon Jan 28 13:48:19 2013
+++ configure	Mon Jan 28 13:50:26 2013
@@ -7890,29 +7890,8 @@
 _ACEOF
 
 
-# The cast to long int works around a bug in the HP C Compiler
-# version HP92453-01 B.11.11.23709.GP, which incorrectly rejects
-# declarations like `int a3[[(sizeof (unsigned char)) >= 0]];'.
-# This bug is HP SR number 8606223364.
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking size of mode_t" >&5
-$as_echo_n "checking size of mode_t... " >&6; }
-if ${ac_cv_sizeof_mode_t+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if ac_fn_c_compute_int "$LINENO" "(long int) (sizeof (mode_t))" "ac_cv_sizeof_mode_t"        "$ac_includes_default"; then :
+     ac_cv_sizeof_mode_t=4
 
-else
-  if test "$ac_cv_type_mode_t" = yes; then
-     { { $as_echo "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
-$as_echo "$as_me: error: in \`$ac_pwd':" >&2;}
-as_fn_error 77 "cannot compute sizeof (mode_t)
-See \`config.log' for more details" "$LINENO" 5; }
-   else
-     ac_cv_sizeof_mode_t=0
-   fi
-fi
-
-fi
 { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_sizeof_mode_t" >&5
 $as_echo "$ac_cv_sizeof_mode_t" >&6; }
 
