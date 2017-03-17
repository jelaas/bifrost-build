--- sapi/cgi/cgi_main.c.orig	Fri Jun 29 08:33:28 2012
+++ sapi/cgi/cgi_main.c	Fri Jun 29 08:35:00 2012
@@ -1395,7 +1395,7 @@
 	STD_PHP_INI_ENTRY("cgi.rfc2616_headers",     "0",  PHP_INI_ALL,    OnUpdateBool,   rfc2616_headers, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.nph",                 "0",  PHP_INI_ALL,    OnUpdateBool,   nph, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.check_shebang_line",  "1",  PHP_INI_SYSTEM, OnUpdateBool,   check_shebang_line, php_cgi_globals_struct, php_cgi_globals)
-	STD_PHP_INI_ENTRY("cgi.force_redirect",      "1",  PHP_INI_SYSTEM, OnUpdateBool,   force_redirect, php_cgi_globals_struct, php_cgi_globals)
+	STD_PHP_INI_ENTRY("cgi.force_redirect",      "0",  PHP_INI_SYSTEM, OnUpdateBool,   force_redirect, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.redirect_status_env", NULL, PHP_INI_SYSTEM, OnUpdateString, redirect_status_env, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.fix_pathinfo",        "1",  PHP_INI_SYSTEM, OnUpdateBool,   fix_pathinfo, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.discard_path",        "0",  PHP_INI_SYSTEM, OnUpdateBool,   discard_path, php_cgi_globals_struct, php_cgi_globals)
@@ -1412,7 +1412,7 @@
 	php_cgi_globals->rfc2616_headers = 0;
 	php_cgi_globals->nph = 0;
 	php_cgi_globals->check_shebang_line = 1;
-	php_cgi_globals->force_redirect = 1;
+	php_cgi_globals->force_redirect = 0;
 	php_cgi_globals->redirect_status_env = NULL;
 	php_cgi_globals->fix_pathinfo = 1;
 	php_cgi_globals->discard_path = 0;
--- sapi/fpm/fpm/fpm_main.c.orig	Fri Jun 29 08:33:40 2012
+++ sapi/fpm/fpm/fpm_main.c	Fri Jun 29 08:35:23 2012
@@ -1406,7 +1406,7 @@
 PHP_INI_BEGIN()
 	STD_PHP_INI_ENTRY("cgi.rfc2616_headers",     "0",  PHP_INI_ALL,    OnUpdateBool,   rfc2616_headers, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.nph",                 "0",  PHP_INI_ALL,    OnUpdateBool,   nph, php_cgi_globals_struct, php_cgi_globals)
-	STD_PHP_INI_ENTRY("cgi.force_redirect",      "1",  PHP_INI_SYSTEM, OnUpdateBool,   force_redirect, php_cgi_globals_struct, php_cgi_globals)
+	STD_PHP_INI_ENTRY("cgi.force_redirect",      "0",  PHP_INI_SYSTEM, OnUpdateBool,   force_redirect, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.redirect_status_env", NULL, PHP_INI_SYSTEM, OnUpdateString, redirect_status_env, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.fix_pathinfo",        "1",  PHP_INI_SYSTEM, OnUpdateBool,   fix_pathinfo, php_cgi_globals_struct, php_cgi_globals)
 	STD_PHP_INI_ENTRY("cgi.discard_path",        "0",  PHP_INI_SYSTEM, OnUpdateBool,   discard_path, php_cgi_globals_struct, php_cgi_globals)
@@ -1421,7 +1421,7 @@
 {
 	php_cgi_globals->rfc2616_headers = 0;
 	php_cgi_globals->nph = 0;
-	php_cgi_globals->force_redirect = 1;
+	php_cgi_globals->force_redirect = 0;
 	php_cgi_globals->redirect_status_env = NULL;
 	php_cgi_globals->fix_pathinfo = 1;
 	php_cgi_globals->discard_path = 0;
