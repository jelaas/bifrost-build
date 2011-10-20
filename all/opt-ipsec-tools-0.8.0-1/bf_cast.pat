--- ./src/racoon/algorithm.c.orig	Thu Oct 20 12:21:22 2011
+++ ./src/racoon/algorithm.c	Thu Oct 20 12:26:46 2011
@@ -111,9 +111,6 @@
 		eay_idea_encrypt,	eay_idea_decrypt,
 		eay_idea_weakkey,	eay_idea_keylen, },
 #endif
-{ "blowfish",	algtype_blowfish,	OAKLEY_ATTR_ENC_ALG_BLOWFISH,	8,
-		eay_bf_encrypt,		eay_bf_decrypt,
-		eay_bf_weakkey,		eay_bf_keylen, },
 #ifdef HAVE_OPENSSL_RC5_H
 { "rc5",	algtype_rc5,		OAKLEY_ATTR_ENC_ALG_RC5,	8,
 		eay_rc5_encrypt,	eay_rc5_decrypt,
@@ -122,9 +119,6 @@
 { "3des",	algtype_3des,		OAKLEY_ATTR_ENC_ALG_3DES,	8,
 		eay_3des_encrypt,	eay_3des_decrypt,
 		eay_3des_weakkey,	eay_3des_keylen, },
-{ "cast",	algtype_cast128,	OAKLEY_ATTR_ENC_ALG_CAST,	8,
-		eay_cast_encrypt,	eay_cast_decrypt,
-		eay_cast_weakkey,	eay_cast_keylen, },
 { "aes",	algtype_aes,	OAKLEY_ATTR_ENC_ALG_AES,	16,
 		eay_aes_encrypt,	eay_aes_decrypt,
 		eay_aes_weakkey,	eay_aes_keylen, },
@@ -150,12 +144,6 @@
 		NULL,			NULL,
 		NULL,			eay_rc5_keylen, },
 #endif
-{ "cast",	algtype_cast128,	IPSECDOI_ESP_CAST,		8,
-		NULL,			NULL,
-		NULL,			eay_cast_keylen, },
-{ "blowfish",	algtype_blowfish,	IPSECDOI_ESP_BLOWFISH,		8,
-		NULL,			NULL,
-		NULL,			eay_bf_keylen, },
 { "des-iv32",	algtype_des_iv32,	IPSECDOI_ESP_DES_IV32,		8,
 		NULL,			NULL,
 		NULL,			eay_des_keylen, },
@@ -794,7 +782,6 @@
 	}
 
 	switch (type) {
-	case algtype_blowfish:
 	case algtype_rc5:
 	case algtype_cast128:
 	case algtype_aes:
@@ -830,7 +817,6 @@
 
 	/* key length must be multiple of 8 bytes - RFC2451 2.2 */
 	switch (type) {
-	case algtype_blowfish:
 	case algtype_rc5:
 	case algtype_cast128:
 	case algtype_aes:
@@ -847,10 +833,6 @@
 	/* key length range */
 	badrange = 0;
 	switch (type) {
-	case algtype_blowfish:
-		if (len < 40 || 448 < len)
-			badrange++;
-		break;
 	case algtype_rc5:
 		if (len < 40 || 2040 < len)
 			badrange++;
--- ./src/racoon/eaytest.c.orig	Thu Oct 20 12:24:02 2011
+++ ./src/racoon/eaytest.c	Thu Oct 20 12:24:17 2011
@@ -684,20 +684,6 @@
 			  eay_aes_encrypt, eay_aes_decrypt) < 0)
 	  return -1;
 
-	if (ciphertest_1 ("BLOWFISH",
-			  &data, 8,
-			  &key, key.l,
-			  &iv0, 8,
-			  eay_bf_encrypt, eay_bf_decrypt) < 0)
-	  return -1;
-
-	if (ciphertest_1 ("CAST",
-			  &data, 8,
-			  &key, key.l,
-			  &iv0, 8,
-			  eay_cast_encrypt, eay_cast_decrypt) < 0)
-	  return -1;
-	
 #ifdef HAVE_OPENSSL_IDEA_H
 	if (ciphertest_1 ("IDEA",
 			  &data, 8,
--- ./src/racoon/crypto_openssl.c.orig	Thu Oct 20 12:14:07 2011
+++ ./src/racoon/crypto_openssl.c	Thu Oct 20 12:23:41 2011
@@ -63,8 +63,6 @@
 #ifdef HAVE_OPENSSL_ENGINE_H
 #include <openssl/engine.h>
 #endif
-#include <openssl/blowfish.h>
-#include <openssl/cast.h>
 #include <openssl/err.h>
 #ifdef HAVE_OPENSSL_RC5_H
 #include <openssl/rc5.h>
@@ -1405,41 +1403,6 @@
 }
 #endif
 
-/*
- * BLOWFISH-CBC
- */
-vchar_t *
-eay_bf_encrypt(data, key, iv)
-	vchar_t *data, *key, *iv;
-{
-	return evp_crypt(data, key, iv, EVP_bf_cbc(), 1);
-}
-
-vchar_t *
-eay_bf_decrypt(data, key, iv)
-	vchar_t *data, *key, *iv;
-{
-	return evp_crypt(data, key, iv, EVP_bf_cbc(), 0);
-}
-
-int
-eay_bf_weakkey(key)
-	vchar_t *key;
-{
-	return 0;	/* XXX to be done. refer to RFC 2451 */
-}
-
-int
-eay_bf_keylen(len)
-	int len;
-{
-	if (len == 0)
-		return 448;
-	if (len < 40 || len > 448)
-		return -1;
-	return len;
-}
-
 #ifdef HAVE_OPENSSL_RC5_H
 /*
  * RC5-CBC
@@ -1548,41 +1511,6 @@
 	if (len != 0 && len != 192)
 		return -1;
 	return 192;
-}
-
-/*
- * CAST-CBC
- */
-vchar_t *
-eay_cast_encrypt(data, key, iv)
-	vchar_t *data, *key, *iv;
-{
-	return evp_crypt(data, key, iv, EVP_cast5_cbc(), 1);
-}
-
-vchar_t *
-eay_cast_decrypt(data, key, iv)
-	vchar_t *data, *key, *iv;
-{
-	return evp_crypt(data, key, iv, EVP_cast5_cbc(), 0);
-}
-
-int
-eay_cast_weakkey(key)
-	vchar_t *key;
-{
-	return 0;	/* No known weak keys. */
-}
-
-int
-eay_cast_keylen(len)
-	int len;
-{
-	if (len == 0)
-		return 128;
-	if (len < 40 || len > 128)
-		return -1;
-	return len;
 }
 
 /*
