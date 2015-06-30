--- src/openssl.h.orig	Thu Dec  2 13:01:03 2010
+++ src/openssl.h	Thu Dec  2 13:05:13 2010
@@ -83,7 +83,7 @@
 #ifdef OPENSSL_NO_BLOWFISH
 # define LIBSSH2_BLOWFISH 0
 #else
-# define LIBSSH2_BLOWFISH 1
+# define LIBSSH2_BLOWFISH 0
 #endif
 
 #ifdef OPENSSL_NO_RC4
@@ -208,7 +208,6 @@
 #define _libssh2_cipher_aes192ctr _libssh2_EVP_aes_192_ctr
 #define _libssh2_cipher_aes256ctr _libssh2_EVP_aes_256_ctr
 #endif
-#define _libssh2_cipher_blowfish EVP_bf_cbc
 #define _libssh2_cipher_arcfour EVP_rc4
 #define _libssh2_cipher_cast5 EVP_cast5_cbc
 #define _libssh2_cipher_3des EVP_des_ede3_cbc
