commit 4b49060da09b37e36ae08b49499c4a53b4f53890
Author: Rich Felker <dalias@aerifal.cx>
Date:   Sat Sep 22 16:19:06 2012 -0400

    fix getaddrinfo to accept port 0 (zero)
    
    new behavior can be summarized as:
    inputs that parse completely as a decimal number are treated as one,
    and rejected only if the result is out of 16-bit range.
    inputs that do not parse as a decimal number (where strtoul leaves
    anything left over in the input) are searched in /etc/services.

diff --git a/src/network/getaddrinfo.c b/src/network/getaddrinfo.c
index b9e562f..b341912 100644
--- a/src/network/getaddrinfo.c
+++ b/src/network/getaddrinfo.c
@@ -76,8 +76,7 @@ int getaddrinfo(const char *restrict host, const char *restrict serv, const stru
 	if (serv) {
 		if (!*serv) return EAI_SERVICE;
 		port = strtoul(serv, &z, 10);
-		if (!*z && port > 65535) return EAI_SERVICE;
-		if (!port) {
+		if (*z) {
 			size_t servlen = strlen(serv);
 			char *end = line;
 
@@ -96,6 +95,7 @@ int getaddrinfo(const char *restrict host, const char *restrict serv, const stru
 			__fclose_ca(f);
 			if (feof(f)) return EAI_SERVICE;
 		}
+		if (port > 65535) return EAI_SERVICE;
 		port = htons(port);
 	}
 
