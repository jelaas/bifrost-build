--- ext/standard/php_crypt_r.c~	Thu Jun 17 10:22:03 2010
+++ ext/standard/php_crypt_r.c	Thu Aug 26 12:11:36 2010
@@ -92,14 +92,7 @@
 #endif
 
 	if (!initialized) {
-#ifdef PHP_WIN32
-		InterlockedIncrement(&initialized);
-#elif (defined(__GNUC__) && (__GNUC__ >= 4 && __GNUC_MINOR >= 2))
 		__sync_fetch_and_add(&initialized, 1);
-#elif defined(HAVE_ATOMIC_H) /* Solaris 10 defines atomic API within */
-		membar_producer();
-		atomic_add_int(&initialized, 1);
-#endif
 		_crypt_extended_init();
 	}
 #ifdef ZTS
