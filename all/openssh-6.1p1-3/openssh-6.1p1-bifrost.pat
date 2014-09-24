--- cipher.c.orig	Fri Feb 15 11:47:09 2013
+++ cipher.c	Fri Feb 15 11:49:58 2013
@@ -51,7 +51,6 @@
 /* compatibility with old or broken OpenSSL versions */
 #include "openbsd-compat/openssl-compat.h"
 
-extern const EVP_CIPHER *evp_ssh1_bf(void);
 extern const EVP_CIPHER *evp_ssh1_3des(void);
 extern void ssh1_3des_iv(EVP_CIPHER_CTX *, int, u_char *, int);
 extern const EVP_CIPHER *evp_aes_128_ctr(void);
@@ -69,11 +68,8 @@
 	{ "none",		SSH_CIPHER_NONE, 8, 0, 0, 0, EVP_enc_null },
 	{ "des",		SSH_CIPHER_DES, 8, 8, 0, 1, EVP_des_cbc },
 	{ "3des",		SSH_CIPHER_3DES, 8, 16, 0, 1, evp_ssh1_3des },
-	{ "blowfish",		SSH_CIPHER_BLOWFISH, 8, 32, 0, 1, evp_ssh1_bf },
 
 	{ "3des-cbc",		SSH_CIPHER_SSH2, 8, 24, 0, 1, EVP_des_ede3_cbc },
-	{ "blowfish-cbc",	SSH_CIPHER_SSH2, 8, 16, 0, 1, EVP_bf_cbc },
-	{ "cast128-cbc",	SSH_CIPHER_SSH2, 8, 16, 0, 1, EVP_cast5_cbc },
 	{ "arcfour",		SSH_CIPHER_SSH2, 8, 16, 0, 0, EVP_rc4 },
 	{ "arcfour128",		SSH_CIPHER_SSH2, 8, 16, 1536, 0, EVP_rc4 },
 	{ "arcfour256",		SSH_CIPHER_SSH2, 8, 32, 1536, 0, EVP_rc4 },
--- mac.c.orig	Fri Feb 15 11:47:12 2013
+++ mac.c	Fri Feb 15 11:48:53 2013
@@ -65,8 +65,6 @@
 #endif
 	{ "hmac-md5",			SSH_EVP, EVP_md5, 0, -1, -1 },
 	{ "hmac-md5-96",		SSH_EVP, EVP_md5, 96, -1, -1 },
-	{ "hmac-ripemd160",		SSH_EVP, EVP_ripemd160, 0, -1, -1 },
-	{ "hmac-ripemd160@openssh.com",	SSH_EVP, EVP_ripemd160, 0, -1, -1 },
 	{ "umac-64@openssh.com",	SSH_UMAC, NULL, 0, 128, 64 },
 	{ NULL,				0, NULL, 0, -1, -1 }
 };
--- cipher-bf1.c.orig	Fri Feb 15 11:47:31 2013
+++ cipher-bf1.c	Fri Feb 15 11:49:30 2013
@@ -91,18 +91,3 @@
 	return (ret);
 }
 
-const EVP_CIPHER *
-evp_ssh1_bf(void)
-{
-	static EVP_CIPHER ssh1_bf;
-
-	memcpy(&ssh1_bf, EVP_bf_cbc(), sizeof(EVP_CIPHER));
-	orig_bf = ssh1_bf.do_cipher;
-	ssh1_bf.nid = NID_undef;
-#ifdef SSH_OLD_EVP
-	ssh1_bf.init = bf_ssh1_init;
-#endif
-	ssh1_bf.do_cipher = bf_ssh1_cipher;
-	ssh1_bf.key_len = 32;
-	return (&ssh1_bf);
-}
