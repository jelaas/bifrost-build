diff -ur net-tools-1.60/Makefile net-tools-1.60-bifrost/Makefile
--- net-tools-1.60/Makefile	2001-04-15 16:34:31.000000000 +0200
+++ net-tools-1.60-bifrost/Makefile	2009-02-17 11:55:58.000000000 +0100
@@ -88,9 +88,9 @@
 
 # Compiler and Linker Options
 # You may need to uncomment and edit these if you are using libc5 and IPv6.
-COPTS = -D_GNU_SOURCE -O2 -Wall -g # -I/usr/inet6/include
+COPTS = -D_GNU_SOURCE -march=i586 -Os -Wall -g # -I/usr/inet6/include
 ifeq ($(origin LOPTS), undefined)
-LOPTS = 
+LOPTS = -static
 endif
 RESLIB = # -L/usr/inet6/lib -linet6
 
@@ -121,7 +121,7 @@
 ifeq ($(origin CC), undefined)
 CC	= gcc
 endif
-LD	= $(CC)
+LD	= $(CC) -static
 
 NLIB	= -l$(NET_LIB_NAME)
 
Only in net-tools-1.60-bifrost: config.h
Only in net-tools-1.60-bifrost: config.make
Only in net-tools-1.60-bifrost: config.status
diff -ur net-tools-1.60/hostname.c net-tools-1.60-bifrost/hostname.c
--- net-tools-1.60/hostname.c	2001-04-08 19:04:23.000000000 +0200
+++ net-tools-1.60-bifrost/hostname.c	2009-02-17 11:49:55.000000000 +0100
@@ -98,6 +98,7 @@
 	    fprintf(stderr, _("%s: name too long\n"), program_name);
 	    break;
 	default:
+      ;
 	}
 	exit(1);
     };
@@ -117,6 +118,7 @@
 	    fprintf(stderr, _("%s: name too long\n"), program_name);
 	    break;
 	default:
+      ;
 	}
 	exit(1);
     };
@@ -174,6 +176,7 @@
 	printf("%s\n", hp->h_name);
 	break;
     default:
+  ;
     }
 }
 
diff -ur net-tools-1.60/lib/inet_sr.c net-tools-1.60-bifrost/lib/inet_sr.c
--- net-tools-1.60/lib/inet_sr.c	2000-02-20 22:46:45.000000000 +0100
+++ net-tools-1.60-bifrost/lib/inet_sr.c	2009-02-17 11:49:55.000000000 +0100
@@ -105,6 +105,7 @@
     case 2:
        isnet = 0; break;
     default:
+       ;
     }
 
     /* Fill in the other fields. */
diff -ur net-tools-1.60/mii-tool.c net-tools-1.60-bifrost/mii-tool.c
--- net-tools-1.60/mii-tool.c	2000-05-21 16:31:17.000000000 +0200
+++ net-tools-1.60-bifrost/mii-tool.c	2009-02-17 11:52:51.000000000 +0100
@@ -379,16 +379,16 @@
 /*--------------------------------------------------------------------*/
 
 const char *usage =
-"usage: %s [-VvRrwl] [-A media,... | -F media] [interface ...]
-       -V, --version               display version information
-       -v, --verbose               more verbose output
-       -R, --reset                 reset MII to poweron state
-       -r, --restart               restart autonegotiation
-       -w, --watch                 monitor for link status changes
-       -l, --log                   with -w, write events to syslog
-       -A, --advertise=media,...   advertise only specified media
-       -F, --force=media           force specified media technology
-media: 100baseT4, 100baseTx-FD, 100baseTx-HD, 10baseT-FD, 10baseT-HD,
+"usage: %s [-VvRrwl] [-A media,... | -F media] [interface ...]\n\
+       -V, --version               display version information\n\
+       -v, --verbose               more verbose output\n\
+       -R, --reset                 reset MII to poweron state\n\
+       -r, --restart               restart autonegotiation\n\
+       -w, --watch                 monitor for link status changes\n\
+       -l, --log                   with -w, write events to syslog\n\
+       -A, --advertise=media,...   advertise only specified media\n\
+       -F, --force=media           force specified media technology\n\
+media: 100baseT4, 100baseTx-FD, 100baseTx-HD, 10baseT-FD, 10baseT-HD,\n\
        (to advertise both HD and FD) 100baseTx, 10baseT\n";
 
 int main(int argc, char **argv)
diff -ur net-tools-1.60/nameif.c net-tools-1.60-bifrost/nameif.c
--- net-tools-1.60/nameif.c	2000-10-18 19:26:29.000000000 +0200
+++ net-tools-1.60-bifrost/nameif.c	2009-02-17 11:49:51.000000000 +0100
@@ -3,7 +3,7 @@
  * Writen 2000 by Andi Kleen.
  * Subject to the Gnu Public License, version 2.  
  * TODO: make it support token ring etc.
- * $Id: nameif.c,v 1.1 2000/10/18 17:26:29 ak Exp $
+ * $Id: nameif.c,v 1.4 2003/09/11 03:46:49 ak Exp $
  */ 
 #ifndef _GNU_SOURCE 
 #define _GNU_SOURCE
@@ -117,7 +117,8 @@
 }
 
 struct change { 
-	struct change *next,**pprev;
+	struct change *next;
+	int found;
 	char ifname[IFNAMSIZ+1];
 	unsigned char mac[6];
 }; 
@@ -139,10 +140,7 @@
 			ch->ifname, pos); 
 	if (parsemac(p,ch->mac) < 0) 
 		complain(_("cannot parse MAC `%s' at %s"), p, pos); 
-	if (clist) 
-		clist->pprev = &ch->next;
 	ch->next = clist;
-	ch->pprev = &clist;
 	clist = ch;
 	return 0; 
 }
@@ -177,7 +175,7 @@
 		if (*p == '\0')
 			continue; 
 		n = strcspn(p, " \t"); 
-		if (n > IFNAMSIZ) 
+		if (n > IFNAMSIZ-1) 
 			complain(_("interface name too long at line %d"), line);  
 		memcpy(ch->ifname, p, n); 
 		ch->ifname[n] = 0; 
@@ -200,7 +198,7 @@
 
 void usage(void)
 {
-	fprintf(stderr, _("usage: nameif [-c configurationfile] [-s] {ifname macaddress}")); 
+	fprintf(stderr, _("usage: nameif [-c configurationfile] [-s] {ifname macaddress}\n")); 
 	exit(1); 
 }
 
@@ -277,21 +275,21 @@
 		ch = lookupmac(mac); 
 		if (!ch) 
 			continue;
-			
-		*ch->pprev = ch->next;
+		
+		ch->found = 1;	
 		if (strcmp(p, ch->ifname)) { 
 			if (setname(p, ch->ifname) < 0)  
 				complain(_("cannot change name of %s to %s: %s"),
 						p, ch->ifname, strerror(errno)); 
 		} 
-		free(ch);
 	} 
 	fclose(ifh); 
 	
 	while (clist) { 
 		struct change *ch = clist;
 		clist = clist->next;
-		warning(_("interface '%s' not found"), ch->ifname); 
+		if (!ch->found)
+			warning(_("interface '%s' not found"), ch->ifname); 
 		free(ch); 
 	}
 
Only in net-tools-1.60-bifrost: version.h
