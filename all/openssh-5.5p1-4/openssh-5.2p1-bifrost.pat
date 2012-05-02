Only in openssh-5.2p1-bifrost: Makefile
Only in openssh-5.2p1-bifrost: buildpkg.sh
--- openssh-5.2p1/cipher.c	Wed Jan 28 05:38:41 2009
+++ openssh-5.2p1-bifrost/cipher.c	Fri Mar  6 12:53:22 2009
@@ -69,11 +69,8 @@
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
Only in openssh-5.2p1-bifrost: config.h
Only in openssh-5.2p1-bifrost: config.status
--- openssh-5.2p1/mac.c	Fri Jun 13 00:58:50 2008
+++ openssh-5.2p1-bifrost/mac.c	Fri Mar  6 12:53:51 2009
@@ -59,8 +59,6 @@
 	{ "hmac-sha1-96",		SSH_EVP, EVP_sha1, 96, -1, -1 },
 	{ "hmac-md5",			SSH_EVP, EVP_md5, 0, -1, -1 },
 	{ "hmac-md5-96",		SSH_EVP, EVP_md5, 96, -1, -1 },
-	{ "hmac-ripemd160",		SSH_EVP, EVP_ripemd160, 0, -1, -1 },
-	{ "hmac-ripemd160@openssh.com",	SSH_EVP, EVP_ripemd160, 0, -1, -1 },
 	{ "umac-64@openssh.com",	SSH_UMAC, NULL, 0, 128, 64 },
 	{ NULL,				0, NULL, 0, -1, -1 }
 };
Only in openssh-5.2p1-bifrost: openbsd-compat/Makefile
Only in openssh-5.2p1-bifrost: openbsd-compat/regress/Makefile
Only in openssh-5.2p1-bifrost: openssh.xml
Only in openssh-5.2p1-bifrost: opensshd.init
Only in openssh-5.2p1-bifrost: scard/Makefile
Only in openssh-5.2p1-bifrost: ssh_prng_cmds
Only in openssh-5.2p1-bifrost: survey.sh
