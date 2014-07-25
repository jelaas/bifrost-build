--- configure.ac.orig	Fri Jul 25 14:30:53 2014
+++ configure.ac	Fri Jul 25 14:33:39 2014
@@ -62,21 +62,8 @@
 [  --disable-ipv6          Do not enable IPv6],
 WANTS_IPV6=$enableval, WANTS_IPV6=yes)
    
-if test "x$WANTS_GTK" = "xyes"; then
-        AM_PATH_GTK_2_0(2.6.0, CFLAGS="$CFLAGS $GTK_CFLAGS"
-                           LIBS="$LIBS $GTK_LIBS -lm",
-                           AC_MSG_WARN(Building without GTK2 display support)
                    AC_DEFINE(NO_GTK, 1, [Define if you don't have the GTK+ libraries available.])
-                           GTK_OBJ="")
-else
-	AC_DEFINE(NO_GTK)
-	GTK_OBJ=""
-	if test "x$WANTS_GLIB" = "xyes"; then
-		PKG_CHECK_MODULES([GLIB], [glib-2.0])
-	else
 		AC_DEFINE(NO_GLIB, 1, [Define if you don't have the glib libraries available.])
-	fi
-fi
 
 AC_CHECK_FUNC(socket, , 
   AC_CHECK_LIB(socket, socket, , AC_MSG_ERROR(No socket library found)))
@@ -142,57 +129,6 @@
 	AC_DEFINE([ENABLE_IPV6], [], [Define to enable IPv6])
 	USES_IPV6=yes
 fi])
-
-AC_DEFUN([NEED_RES_STATE_EXT_TEST_SRC], [
-AC_LANG_PROGRAM([[
-#include <netinet/in.h>
-#include <resolv.h>
-#ifdef __GLIBC__
-#define RESEXTIN6(r,i) (*(r._u._ext.nsaddrs[i]))
-#else
-#define RESEXTIN6(r,i) (r._u._ext.ext->nsaddrs[i].sin6)
-#endif
-]], [[
-struct __res_state res;
-return RESEXTIN6(res,0).sin6_addr.s6_addr[0];
-]])])
-AC_DEFUN([DEFINE_RES_STATE_EXT_TEST_SRC], [
-AC_LANG_PROGRAM([[
-#include <netinet/in.h>
-#include <resolv.h>
-#ifdef __GLIBC__
-#define RESEXTIN6(r,i) (*(r._u._ext.nsaddrs[i]))
-#else
-#define RESEXTIN6(r,i) (r._u._ext.ext->nsaddrs[i].sin6)
-struct __res_state_ext {
-	union res_sockaddr_union nsaddrs[MAXNS];
-	struct sort_list {
-		int     af;
-		union {
-			struct in_addr  ina;
-			struct in6_addr in6a;
-		} addr, mask;
-	} sort_list[MAXRESOLVSORT];
-	char nsuffix[64];
-	char nsuffix2[64];
-};
-#endif
-]], [[
-struct __res_state res;
-return RESEXTIN6(res,0).sin6_addr.s6_addr[0];
-]])])
-if test "x$USES_IPV6" = "xyes"; then
-	AC_MSG_CHECKING([whether __res_state_ext needs to be defined])
-	AC_COMPILE_IFELSE([NEED_RES_STATE_EXT_TEST_SRC],
-		[AC_MSG_RESULT([no])],
-		[AC_MSG_RESULT([yes])
-		AC_MSG_CHECKING([whether provided __res_state_ext definition can be compiled])
-		AC_COMPILE_IFELSE([DEFINE_RES_STATE_EXT_TEST_SRC],
-			[AC_MSG_RESULT([yes])
-			AC_DEFINE(NEED_RES_STATE_EXT, 1, [Define if struct __res_state_ext needs to be defined.])],
-			[AC_MSG_RESULT([no])
-			AC_MSG_ERROR(Need definition for struct __res_state_ext but unable to define it.)])])
-fi
 
 AC_CHECK_DECLS(errno, , , [[
 #include <errno.h>
