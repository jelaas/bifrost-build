diff --git a/.gitignore b/.gitignore
index f9049cb..ec6d288 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,4 +23,3 @@ stamp-h1*
 /version.h
 /version.h.tmp
 
-compile
diff --git a/configure.ac b/configure.ac
index ab0ae84..c4a9a32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,4 +1,4 @@
-AC_INIT([mtr], [0.87])
+AC_INIT([mtr], [0.86])
 AC_CONFIG_SRCDIR([mtr.c])
 AM_INIT_AUTOMAKE([foreign])
 
@@ -133,57 +133,6 @@ AC_CHECK_FUNC(getaddrinfo,
 	USES_IPV6=yes
 fi])
 
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
-
 AC_CHECK_DECLS(errno, , , [[
 #include <errno.h>
 #include <sys/errno.h>
diff --git a/display.c b/display.c
index 584c7a0..d98863d 100644
--- a/display.c
+++ b/display.c
@@ -88,9 +88,6 @@ void display_open(void)
   case DisplayTXT:
     txt_open();
     break;
-  case DisplayJSON:
-    json_open();
-    break;
   case DisplayXML:
     xml_open();
     break;
@@ -127,9 +124,6 @@ void display_close(time_t now)
   case DisplayTXT:
     txt_close();
     break;
-  case DisplayJSON:
-    json_close();
-    break;
   case DisplayXML:
     xml_close();
     break;
@@ -203,7 +197,6 @@ void display_rawping(int host, int msec, int seq)
   switch(DisplayMode) {
   case DisplayReport:
   case DisplayTXT:
-  case DisplayJSON:
   case DisplayXML:
   case DisplayCSV:
   case DisplaySplit:
@@ -222,7 +215,6 @@ void display_rawhost(int host, ip_t *ip_addr)
   switch(DisplayMode) {
   case DisplayReport:
   case DisplayTXT:
-  case DisplayJSON:
   case DisplayXML:
   case DisplayCSV:
   case DisplaySplit:
@@ -241,7 +233,6 @@ void display_loop(void)
   switch(DisplayMode) {
   case DisplayReport:
   case DisplayTXT:
-  case DisplayJSON:
   case DisplayXML:
   case DisplayCSV:
   case DisplaySplit:
@@ -264,7 +255,6 @@ void display_clear(void)
     break;
   case DisplayReport:
   case DisplayTXT:
-  case DisplayJSON:
   case DisplayXML:
   case DisplayCSV:
   case DisplaySplit:
diff --git a/display.h b/display.h
index 294f618..eb821ea 100644
--- a/display.h
+++ b/display.h
@@ -27,7 +27,7 @@ enum { ActionNone,  ActionQuit,  ActionReset,  ActionDisplay,
 #endif
        ActionScrollDown, ActionScrollUp  };
 enum { DisplayReport, DisplayCurses, DisplayGTK, DisplaySplit, 
-       DisplayRaw,    DisplayXML,    DisplayCSV, DisplayTXT, DisplayJSON};
+       DisplayRaw,    DisplayXML,    DisplayCSV, DisplayTXT};
 
 /*  Prototypes for display.c  */
 void display_detect(int *argc, char ***argv);
diff --git a/dns.c b/dns.c
index 3e7cf4d..a5ba0dd 100644
--- a/dns.c
+++ b/dns.c
@@ -24,443 +24,55 @@
 
 #include "config.h"
 
-#include <sys/types.h>
-#include <sys/time.h>
-#include <sys/select.h>
-#include <sys/stat.h>
-#include <sys/errno.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-
-#ifndef __APPLE__
-#define BIND_8_COMPAT
-#endif
-#include <arpa/nameser.h>
-#ifdef HAVE_ARPA_NAMESER_COMPAT_H
-#include <arpa/nameser_compat.h>
-#endif
-#include <netdb.h>
-#include <resolv.h>
+// This was a big "include everything" section. I've now commented out
+// most includes and we'll get complaints if we need something. Compiles
+// cleanly like this on Unbuntu 14.04 -- REW
+// AQ: Added signal.h for RedHat derivatives. 
+//#include <sys/types.h>
+//#include <sys/time.h>
+//#include <sys/select.h>
+//#include <sys/stat.h>
+//#include <sys/errno.h>
+//#include <sys/socket.h>
+//#include <netinet/in.h>
+//#include <arpa/inet.h>
+
+//#ifndef __APPLE__
+//#define BIND_8_COMPAT
+//#endif
+//#include <arpa/nameser.h>
+//#ifdef HAVE_ARPA_NAMESER_COMPAT_H
+//#include <arpa/nameser_compat.h>
+//#endif
+//#include <netdb.h>
+//#include <resolv.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <ctype.h>
-#include <string.h>
+//#include <ctype.h>
+//#include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <time.h>
+#include <signal.h>
+//#include <errno.h>
+//#include <time.h>
 
 #include "mtr.h"
 #include "dns.h"
 #include "net.h"
 
-#ifdef ENABLE_IPV6
-#ifdef __GLIBC__
-#define NSSOCKADDR6(i) (myres._u._ext.nsaddrs[i])
-#else
-#define NSSOCKADDR6(i) (&(myres._u._ext.ext->nsaddrs[i].sin6))
-#endif
-#endif
-
-
-#ifdef NO_STRERROR
-extern int sys_nerr;
-extern char *sys_errlist[];
-#define strerror(errno) (((errno) >= 0 && (errno) < sys_nerr) ? sys_errlist[errno] : "unlisted error")
-#endif
-
-#if !HAVE_DECL_ERRNO
-/*  Hmm, it seems Irix requires this  */
-extern int errno;
-#endif
-
 extern int af;
 
-/* Defines */
-
-#undef Debug
-
-#undef CorruptCheck
-#undef WipeFrees
-#undef WipeMallocs
-
-#define BashSize 8192			/* Size of hash tables */
-#define BashModulo(x) ((x) & 8191)	/* Modulo for hash table size: */
-#define HostnameLength 255		/* From RFC */
-#define ResRetryDelay1 3
-#define ResRetryDelay2 4
-#define ResRetryDelay3 5
-
-/* Macros */
-
-#define nonull(s) (s) ? s : nullstring
-
-/* Structures */
-
-struct resolve {
-   struct resolve *next;
-   struct resolve *previous;
-   struct resolve *nextid;
-   struct resolve *previousid;
-   struct resolve *nextip;
-   struct resolve *previousip;
-   struct resolve *nexthost;
-   struct resolve *previoushost;
-   float expiretime; /* Fucking HPUX has a problem with "double" here. */
-   char *hostname;
-   ip_t ip;
-   word id;
-   byte state;
-};
-
-/* Non-blocking nameserver interface routines */
-
-#define MaxPacketsize (PACKETSZ)
-#define DomainLength (MAXDNAME)
-
-#define OpcodeCount 3
-char *opcodes[OpcodeCount+1] = {
-   "standard query",
-   "inverse query",
-   "server status request",
-   "unknown",
-};
-
-#define ResponsecodeCount 6
-char *responsecodes[ResponsecodeCount+1] = {
-   "no error",
-   "format error in query",
-   "server failure",
-   "queried domain name does not exist",
-   "requested query type not implemented",
-   "refused by name server",
-   "unknown error",
-};
-
-#define ResourcetypeCount 17
-char *resourcetypes[ResourcetypeCount+1] = {
-   "unknown type",
-   "A: host address",
-   "NS: authoritative name server",
-   "MD: mail destination (OBSOLETE)",
-   "MF: mail forwarder (OBSOLETE)",
-   "CNAME: name alias",
-   "SOA: authority record",
-   "MB: mailbox domain name (EXPERIMENTAL)",
-   "MG: mail group member (EXPERIMENTAL)",
-   "MR: mail rename domain name (EXPERIMENTAL)",
-   "NULL: NULL RR (EXPERIMENTAL)",
-   "WKS: well known service description",
-   "PTR: domain name pointer",
-   "HINFO: host information",
-   "MINFO: mailbox or mail list information",
-   "MX: mail exchange",
-   "TXT: text string",
-   "unknown type",
-};
-
-#define ClasstypeCount 5
-char *classtypes[ClasstypeCount+1] = {
-   "unknown class",
-   "IN: the Internet",
-   "CS: CSNET (OBSOLETE)",
-   "CH: CHAOS",
-   "HS: Hesoid [Dyer 87]",
-   "unknown class"
-};
-
-char *rrtypes[] = {
-   "Unknown",
-   "Query",
-   "Answer",
-   "Authority reference",
-   "Resource reference",
-};
-
-
-/* Please don't use a trailing comma in enumerations: It doesn't
-   work on all compilers */
-enum {
-   RR_UNKNOWN,
-   RR_QUERY,
-   RR_ANSWER,
-   RR_AUTHORITY,
-   RR_RESOURCE
-};
-
-typedef struct {
-   word id;             /* Packet id */
-   byte databyte_a;
-      /* rd:1           recursion desired
-       * tc:1           truncated message
-       * aa:1           authoritative answer
-       * opcode:4       purpose of message
-       * qr:1           response flag
-       */
-   byte databyte_b;
-      /* rcode:4        response code
-       * unassigned:2   unassigned bits
-       * pr:1           primary server required (non standard)
-       * ra:1           recursion available
-       */
-   word qdcount;        /* Query record count */
-   word ancount;        /* Answer record count */
-   word nscount;        /* Authority reference record count */
-   word arcount;        /* Resource reference record count */
-} packetheader;
-
-#ifndef HFIXEDSZ
-#define HFIXEDSZ (sizeof(packetheader))
-#endif
-
-/*
- * Byte order independent macros for packetheader
- */
-#define getheader_rd(x) (x->databyte_a & 1)
-#define getheader_tc(x) ((x->databyte_a >> 1) & 1)
-#define getheader_aa(x) ((x->databyte_a >> 2) & 1)
-#define getheader_opcode(x) ((x->databyte_a >> 3) & 15)
-#define getheader_qr(x) (x->databyte_a >> 7)
-#define getheader_rcode(x) (x->databyte_b & 15)
-#define getheader_pr(x) ((x->databyte_b >> 6) & 1)
-#define getheader_ra(x) (x->databyte_b >> 7)
-
-#if 0
-
-/* The execution order inside an expression is undefined! That means that
-   this might work, but then again, it might not... */
-
-#define sucknetword(x) (((word)*(x) << 8) | (((x)+= 2)[-1]))
-#define sucknetshort(x) (((short)*(x) << 8) | (((x)+= 2)[-1]))
-#define sucknetdword(x) (((dword)*(x) << 24) | ((x)[1] << 16) | ((x)[2] << 8) | (((x)+= 4)[-1]))
-#define sucknetlong(x) (((long)*(x) << 24) | ((x)[1] << 16) | ((x)[2] << 8) | (((x)+= 4)[-1]))
-#else
-
-#define sucknetword(x)  ((x)+=2,((word)  (((x)[-2] <<  8) | ((x)[-1] <<  0))))
-#define sucknetshort(x) ((x)+=2,((short) (((x)[-2] <<  8) | ((x)[-1] <<  0))))
-#define sucknetdword(x) ((x)+=4,((dword) (((x)[-4] << 24) | ((x)[-3] << 16) | \
-                                          ((x)[-2] <<  8) | ((x)[-1] <<  0))))
-#define sucknetlong(x)  ((x)+=4,((long)  (((x)[-4] << 24) | ((x)[-3] << 16) | \
-                                          ((x)[-2] <<  8) | ((x)[-1] <<  0))))
-#endif
-
-enum {
-   STATE_FINISHED,
-   STATE_FAILED,
-   STATE_PTRREQ1,
-   STATE_PTRREQ2,
-   STATE_PTRREQ3
-};
-
-#define Is_PTR(x) ((x->state == STATE_PTRREQ1) || (x->state == STATE_PTRREQ2) || (x->state == STATE_PTRREQ3))
-
-dword resrecvbuf[(MaxPacketsize + 7) >> 2]; /* MUST BE DWORD ALIGNED */
-
-struct resolve *idbash[BashSize];
-struct resolve *ipbash[BashSize];
-struct resolve *hostbash[BashSize];
-struct resolve *expireresolves = NULL;
-struct resolve *lastresolve = NULL;
-struct logline *streamlog = NULL;
-struct logline *lastlog = NULL;
-
-ip_t alignedip;
-ip_t localhost;
-#ifdef ENABLE_IPV6
-ip_t localhost6;
-#endif
-
-double sweeptime;
-
-#ifdef Debug
-int debug = 1;
-#else
-int debug = 0;
-#endif
-
-dword mem = 0;
-
-dword res_iplookupsuccess = 0;
-dword res_reversesuccess = 0;
-dword res_nxdomain = 0;
-dword res_nserror = 0;
-dword res_hostipmismatch = 0;
-dword res_unknownid = 0;
-dword res_resend = 0;
-dword res_timeout = 0;
-
-dword resolvecount = 0;
-
-long idseed = 0xdeadbeef;
-long aseed;
-
-#ifdef ENABLE_IPV6
-struct sockaddr_storage from_sastruct;
-struct sockaddr_in6 * from6 = (struct sockaddr_in6 *) &from_sastruct;
-#else
-struct sockaddr_in from_sastruct;
-#endif
-
-struct sockaddr_in * from4 = (struct sockaddr_in *) &from_sastruct;
-struct sockaddr * from = (struct sockaddr *) &from_sastruct;
-
-int resfd;
-#ifdef ENABLE_IPV6
-int resfd6;
-#endif
-socklen_t fromlen = sizeof from_sastruct;
-
-char tempstring[16384+1+1];
-char sendstring[1024+1];
-char namestring[1024+1];
-char stackstring[1024+1];
-
-char nullstring[] = "";
 
 int use_dns = 1;
 
-#ifdef res_ninit
-#define MY_RES_INIT() res_ninit(&myres);
-#define RES_MKQUERY(a, b, c, d, e, f, g, h, i) \
-    res_nmkquery(&myres, a, b, c, d, e, f, g, h, i)
-struct __res_state myres;
-#else
-#define MY_RES_INIT() res_init();
-#define RES_MKQUERY(a, b, c, d, e, f, g, h, i) \
-    res_mkquery(a, b, c, d, e, f, g, h, i)
-#define myres _res
-#endif
-
-/* Code */
-#ifdef CorruptCheck
-#define TOT_SLACK 2
-#define HEAD_SLACK 1
-/* Need an entry for sparc systems here too. 
-   Don't try this on Sparc for now. */
-#else
-#ifdef sparc
-#define TOT_SLACK 2
-#define HEAD_SLACK 2
-#else
-#define TOT_SLACK 1
-#define HEAD_SLACK 1
-#endif
-#endif
-
-
-void *statmalloc(size_t size)
-{
-  void *p;
-  size_t mallocsize;
 
-  mem+= size;
-  mallocsize = size + TOT_SLACK * sizeof(dword);
-
-  p = malloc(mallocsize);
-  if (!p) {
-    fprintf(stderr,"malloc() of %u bytes failed: %s\n", (unsigned int)size, strerror(errno));
-    exit(-1);
-  }
-  *((dword *)p) = (dword)size;
-#ifdef CorruptCheck
-  *(byte *)((char *)p + size + sizeof(dword) + sizeof(byte) * 0) = 0xde;
-  *(byte *)((char *)p + size + sizeof(dword) + sizeof(byte) * 1) = 0xad;
-  *(byte *)((char *)p + size + sizeof(dword) + sizeof(byte) * 2) = 0xbe;
-  *(byte *)((char *)p + size + sizeof(dword) + sizeof(byte) * 3) = 0xef;
-#endif
-  p = (void *)((dword *)p + HEAD_SLACK);
-#ifdef WipeMallocs
-  memset(p,0xf0,size);
-#endif
-  return p;
-}
-
-
-void statfree(void *p)
-{
-  if (p) {
-    if (*((dword *)p - HEAD_SLACK) == 0) {
-      fprintf(stderr,"ERROR: Attempt to free pointer twice.\n");
-      abort();
-      exit(-1);
-    } else {
-      if (*((dword *)p - HEAD_SLACK) > 8192) {
-	fprintf (stderr,"ERROR: Corrupted free() buffer. (header)\n");
-        abort();
-	exit(-1);
-      }
-#ifdef CorruptCheck
-      if ((*(byte *)((char *)p + (*((dword *)p - 1)) + sizeof(byte) * 0) != 0xde) ||
-	  (*(byte *)((char *)p + (*((dword *)p - 1)) + sizeof(byte) * 1) != 0xad) ||
-	  (*(byte *)((char *)p + (*((dword *)p - 1)) + sizeof(byte) * 2) != 0xbe) ||
-	  (*(byte *)((char *)p + (*((dword *)p - 1)) + sizeof(byte) * 3) != 0xef)) {
-	fprintf(stderr,"ERROR: Corrupted free() buffer. (footer)\n");
-	abort();
-	exit(-1);
-      }
-#endif
-      mem-= *((dword *)p - HEAD_SLACK);
-#ifdef WipeFrees
-      memset(p,0xfe,*((dword *)p - HEAD_SLACK));
-      *((dword *)p - 1) = 0;
-#endif
-      free((dword *)p - HEAD_SLACK);
-    }
-  }
-}
-
-
-char *strtdiff(char *d,long signeddiff)
-{
-  dword diff;
-  dword seconds,minutes,hours;
-  long days;
-
-  if ((diff = labs(signeddiff))) {
-    seconds = diff % 60; diff/= 60;
-    minutes = diff % 60; diff/= 60;
-    hours = diff % 24;
-    days = signeddiff / (60 * 60 * 24);
-    if (days)
-      sprintf(d,"%lid",days);
-    else
-      *d = '\0';
-    if (hours)
-      sprintf(d + strlen(d),"%luh",hours);
-    if (minutes)
-      sprintf(d + strlen(d),"%lum",minutes);
-    if (seconds)
-      sprintf(d + strlen(d),"%lus",seconds);
-  } else
-    sprintf(d,"0s");
-  return d;
-}
-
-
-int issetfd(fd_set *set,int fd)
-{
-  return (int)((FD_ISSET(fd,set)) && 1);
-}
-
-
-void setfd(fd_set *set,int fd)
-{
-  FD_SET(fd,set);
-}
-
-
-void clearfd(fd_set *set,int fd)
-{
-  FD_CLR(fd,set);
-}
-
-
-void clearset(fd_set *set)
-{
-  FD_ZERO(set);
-}
+struct dns_results {
+  ip_t ip; 
+  char *name;
+  struct dns_results *next;
+};
 
+struct dns_results *results;
 
 char *strlongip(ip_t * ip)
 {
@@ -495,973 +107,217 @@ struct hostent * dns_forward(const char *name)
 }
 
 
-int dns_waitfd(void)
-{
-  return resfd;
-}
-#ifdef ENABLE_IPV6
-int dns_waitfd6(void)
-{
-  return resfd6;
-}
-#endif
-
-
-void dns_open(void)
+struct dns_results *findip (ip_t *ip)
 {
-  int option,i;
-
-  if (!dns) return;
-  MY_RES_INIT();
-  if (!myres.nscount) {
-    fprintf(stderr,"No nameservers defined.\n");
-    exit(-1);
-  }
-  myres.options|= RES_RECURSE | RES_DEFNAMES | RES_DNSRCH;
-  resfd = socket(AF_INET, SOCK_DGRAM, 0);
-  if (resfd == -1) {
-    fprintf(stderr,
-            "Unable to allocate IPv4 socket for nameserver communication: %s\n",
-	    strerror(errno));
-    exit(-1);
+  struct dns_results *t;
+  
+  //printf ("Looking for: %s\n",  strlongip (ip));
+  for (t=results;t;t=t->next) {
+    //printf ("comparing: %s\n",  strlongip (&t->ip));
+    if (addrcmp ( (void *)ip, (void*) &t->ip, af) == 0)
+      return t;
   }
-#ifdef ENABLE_IPV6
-  resfd6 = socket(AF_INET6, SOCK_DGRAM, 0);
-  // If this fails, e.g. because the user has runtime-disabled IPV6, 
-  // the error can be ignored: the resfd6 is only used if it is 
-  // not the error return code. -- REW
-#endif
-  option = 1;
-  if (setsockopt(resfd,SOL_SOCKET,SO_BROADCAST,(char *)&option,sizeof(option))) {
-    fprintf(stderr,
-            "Unable to setsockopt() on IPv4 nameserver communication socket: %s\n",
-	    strerror(errno));
-    exit(-1);
-  }
-#ifdef ENABLE_IPV6
-  if (resfd6 > 0) {
-    if (setsockopt(resfd6,SOL_SOCKET,SO_BROADCAST,(char *)&option,sizeof(option))) {
-      fprintf(stderr,
-	      "Unable to setsockopt() on IPv6 nameserver communication socket: %s\n",
-	      strerror(errno));
-      exit(-1);
-    }
-  }
-#endif
-  longipstr( "127.0.0.1", &localhost, AF_INET );
-#ifdef ENABLE_IPV6
-  longipstr( "::1", &localhost6, AF_INET6 );
-#endif
-  aseed = time(NULL) ^ (time(NULL) << 3) ^ (dword)getpid();
-  for (i = 0;i < BashSize;i++) {
-    idbash[i] = NULL;
-    hostbash[i] = NULL;
-  }
-}
-
-
-struct resolve *allocresolve(void)
-{
-  struct resolve *rp;
-
-  rp = (struct resolve *)statmalloc(sizeof(struct resolve));
-  if (!rp) {
-    fprintf(stderr,"statmalloc() failed: %s\n",strerror(errno));
-    exit(-1);
-  }
-  memset(rp,0, sizeof(struct resolve));
-  return rp;
-}
-
 
-dword getidbash(word id)
-{
-  return (dword)BashModulo(id);
+  return NULL;
 }
 
-
-dword getipbash(ip_t * ip)
+void set_sockaddr_ip (struct sockaddr_storage *sa, ip_t *ip)
 {
-  char *p = (char *) ip;
-  int i, len = 0;
-  dword bashvalue = 0;
+  struct sockaddr_in *sa_in;
+  struct sockaddr_in6 *sa_in6;
 
-  switch ( af ) {
+  bzero (sa, sizeof (struct sockaddr_storage));
+  switch (af) {
   case AF_INET:
-    len = sizeof (struct in_addr);
+    sa_in = (struct sockaddr_in *) sa;
+    sa_in->sin_family = af;
+    addrcpy ((void *) &sa_in->sin_addr, (void*) ip, af);
     break;
-#ifdef ENABLE_IPV6
   case AF_INET6:
-    len = sizeof (struct in6_addr);
+    sa_in6 = (struct sockaddr_in6 *) sa;
+    sa_in6->sin6_family = af;
+    addrcpy ((void *) &sa_in6->sin6_addr,  (void*)ip, af);
     break;
-#endif
-  }
-  for (i = 0; i < len; i++, p++) {
-    bashvalue^= *p;
-    bashvalue+= (*p >> 1) + (bashvalue >> 1);
   }
-  return BashModulo(bashvalue);
 }
 
 
-dword gethostbash(char *host)
-{
-  dword bashvalue = 0;
+static int todns[2], fromdns[2];
+FILE *fromdnsfp;
 
-  for (;*host;host++) {
-    bashvalue^= *host;
-    bashvalue+= (*host >> 1) + (bashvalue >> 1);
-  }
-  return BashModulo(bashvalue);
+#if 0
+void handle_sigchld(int sig) {
+  while (waitpid((pid_t)(-1), 0, WNOHANG) > 0) {}
 }
+#endif
 
-
-void linkresolveid(struct resolve *addrp)
+void dns_open(void)
 {
-  struct resolve *rp;
-  dword bashnum;
-
-  bashnum = getidbash(addrp->id);
-  rp = idbash[bashnum];
-  if (rp) {
-    while ((rp->nextid) && (addrp->id > rp->nextid->id))
-      rp = rp->nextid;
-    while ((rp->previousid) && (addrp->id < rp->previousid->id))
-      rp = rp->previousid;
-    if (rp->id < addrp->id) {
-      addrp->previousid = rp;
-      addrp->nextid = rp->nextid;
-      if (rp->nextid)
-	rp->nextid->previousid = addrp;
-      rp->nextid = addrp;
-    } else {
-      addrp->previousid = rp->previousid;
-      addrp->nextid = rp;
-      if (rp->previousid)
-	rp->previousid->nextid = addrp;
-      rp->previousid = addrp;
-    }
-  } else
-    addrp->nextid = addrp->previousid = NULL;
-  idbash[bashnum] = addrp;
-}
-
+  int pid; 
+ 
+  if (pipe (todns) < 0) {
+    perror ("can't make a pipe for DNS process");
+    exit (-1);
+  }
 
-void unlinkresolveid(struct resolve *rp)
-{
-  dword bashnum;
-
-  bashnum = getidbash(rp->id);
-  if (idbash[bashnum] == rp) 
-    idbash[bashnum] = (rp->previousid)? rp->previousid : rp->nextid;
-  if (rp->nextid)
-    rp->nextid->previousid = rp->previousid;
-  if (rp->previousid)
-    rp->previousid->nextid = rp->nextid;
-}
+  if (pipe (fromdns) < 0) {
+    perror ("can't make a pipe for DNS process");
+    exit (-1);
+  }
 
+  pid = fork ();
+  //pid = 1;
+  if (pid < 0) {
+    perror ("can't fork for DNS process");
+    exit (-1);
+  }
+  if (pid == 0) {
+    char buf[2048];
+    int i;
+    FILE *infp; //, *outfp;
 
-void linkresolvehost(struct resolve *addrp)
-{
-  struct resolve *rp;
-  dword bashnum;
-
-  bashnum = gethostbash(addrp->hostname);
-  rp = hostbash[bashnum];
-  if (rp) {
-    while ((rp->nexthost) && (strcasecmp(addrp->hostname,rp->nexthost->hostname) < 0))
-      rp = rp->nexthost;
-    while ((rp->previoushost) && (strcasecmp(addrp->hostname,rp->previoushost->hostname) > 0))
-      rp = rp->previoushost;
-    if (strcasecmp(addrp->hostname,rp->hostname) < 0) {
-      addrp->previoushost = rp;
-      addrp->nexthost = rp->nexthost;
-      if (rp->nexthost)
-	rp->nexthost->previoushost = addrp;
-      rp->nexthost = addrp;
-    } else {
-      addrp->previoushost = rp->previoushost;
-      addrp->nexthost = rp;
-      if (rp->previoushost)
-	rp->previoushost->nexthost = addrp;
-      rp->previoushost = addrp;
+    // Automatically reap children. 
+    if (signal(SIGCHLD, SIG_IGN) == SIG_ERR) {
+      perror("signal");
+      exit(1);
     }
-  } else
-    addrp->nexthost = addrp->previoushost = NULL;
-  hostbash[bashnum] = addrp;
-}
-
-
-void unlinkresolvehost(struct resolve *rp)
-{
-  dword bashnum;
-
-  bashnum = gethostbash(rp->hostname);
-  if (hostbash[bashnum] == rp)
-    hostbash[bashnum] = (rp->previoushost)? rp->previoushost : rp->nexthost;
-  if (rp->nexthost)
-    rp->nexthost->previoushost = rp->previoushost;
-  if (rp->previoushost)
-    rp->previoushost->nexthost = rp->nexthost;
-  statfree(rp->hostname);
-}
-
 
-void linkresolveip(struct resolve *addrp)
-{
-  struct resolve *rp;
-  dword bashnum;
-
-  bashnum = getipbash( &(addrp->ip) );
-  rp = ipbash[bashnum];
-  if (rp) {
-    while ((rp->nextip) &&
-	   ( addrcmp( (void *) &(addrp->ip),
-		      (void *) &(rp->nextip->ip), af ) > 0 ))
-      rp = rp->nextip;
-    while ((rp->previousip) &&
-	   ( addrcmp( (void *) &(addrp->ip),
-		      (void *) &(rp->previousip->ip), af ) < 0 ))
-      rp = rp->previousip;
-    if ( addrcmp( (void *) &(rp->ip), (void *) &(addrp->ip), af ) < 0 ) {
-      addrp->previousip = rp;
-      addrp->nextip = rp->nextip;
-      if (rp->nextip)
-	rp->nextip->previousip = addrp;
-      rp->nextip = addrp;
-    } else {
-      addrp->previousip = rp->previousip;
-      addrp->nextip = rp;
-      if (rp->previousip)
-	rp->previousip->nextip = addrp;
-      rp->previousip = addrp;
+#if 0
+    // No longer necessary: we close all of them below.
+    // The child: We're going to handle the DNS requests here. 
+    close (todns[1]); // close the pipe ends we don't need. 
+    close (fromdns[0]);
+#endif
+    // Close all unneccessary FDs.
+    // for debugging and error reporting, keep std-in/out/err.
+    for (i=3;i<fromdns[1];i++) {
+       if (i == todns[0]) continue;
+       if (i == fromdns[1]) continue;
+       close (i);
     }
-  } else
-    addrp->nextip = addrp->previousip = NULL;
-  ipbash[bashnum] = addrp;
-}
-
-
-void unlinkresolveip(struct resolve *rp)
-{
-  dword bashnum;
-
-  bashnum = getipbash( &(rp->ip) );
-  if (ipbash[bashnum] == rp)
-    ipbash[bashnum] = (rp->previousip)? rp->previousip : rp->nextip;
-  if (rp->nextip)
-    rp->nextip->previousip = rp->previousip;
-  if (rp->previousip)
-    rp->previousip->nextip = rp->nextip;
-}
-
+    infp = fdopen (todns[0],"r"); 
+    //outfp = fdopen (fromdns[1],"w"); 
+
+    while (fgets (buf, sizeof (buf), infp)) {
+      ip_t host; 
+      struct sockaddr_storage sa;
+      socklen_t salen;
+      char hostname [NI_MAXHOST];
+      char result [INET6_ADDRSTRLEN + NI_MAXHOST + 2];
+
+      if (!fork ()) {
+        int rv;
+
+        buf[strlen(buf)-1] = 0; // chomp newline.
+
+        longipstr (buf, &host, af);
+        //printf ("resolving %s (%d)\n", strlongip (&host), af);
+        set_sockaddr_ip (&sa, &host);
+        salen = (af == AF_INET)?sizeof(struct sockaddr_in):
+                                sizeof(struct sockaddr_in6);
+
+        rv = getnameinfo  ((struct sockaddr *) &sa, salen, 
+			       hostname, sizeof (hostname), NULL, 0, 0);
+        if (rv == 0) {
+          sprintf (result, "%s %s\n", strlongip (&host), hostname);
+          //printf ("resolved: %s -> %s (%d)\n", strlongip (&host), hostname, rv);
+          rv = write (fromdns[1], result, strlen (result));
+          if (rv < 0) perror ("write DNS lookup result");
+        }
 
-void linkresolve(struct resolve *rp)
-{
-  struct resolve *irp;
-
-  if (expireresolves) {
-    irp = expireresolves;
-    while ((irp->next) && (rp->expiretime >= irp->expiretime)) irp = irp->next;
-    if (rp->expiretime >= irp->expiretime) {
-      rp->next = NULL;
-      rp->previous = irp;
-      irp->next = rp;
-      lastresolve = rp;
-    } else {
-      rp->previous = irp->previous;
-      rp->next = irp;
-      if (irp->previous)
-	irp->previous->next = rp;
-      else
-	expireresolves = rp;
-      irp->previous = rp;
+        exit (0);
+      }
     }
+    exit (0);
   } else {
-    rp->next = NULL;
-    rp->previous = NULL;
-    expireresolves = lastresolve = rp;
-  }
-  resolvecount++;
-}
+     int flags;
 
-
-void lastlinkresolve(struct resolve *rp)
-{
-  struct resolve *irp;
-
-  if (lastresolve) {
-    irp = lastresolve;
-    while ((irp->previous) && (rp->expiretime < irp->expiretime)) irp = irp->previous;
-    while ((irp->next) && (rp->expiretime >= irp->expiretime)) irp = irp->next;
-    if (rp->expiretime >= irp->expiretime) {
-      rp->next = NULL;
-      rp->previous = irp;
-      irp->next = rp;
-      lastresolve = rp;
-    } else {
-      rp->previous = irp->previous;
-      rp->next = irp;
-      if (irp->previous)
-	irp->previous->next = rp;
-      else
-	expireresolves = rp;
-      irp->previous = rp;
-    }
-  } else {
-    rp->next = NULL;
-    rp->previous = NULL;
-    expireresolves = lastresolve = rp;
+     // the parent. 
+     close (todns[0]); // close the pipe ends we don't need. 
+     close (fromdns[1]);
+     fromdnsfp = fdopen (fromdns[0],"r"); 
+     flags = fcntl(fromdns[0], F_GETFL, 0);
+     flags |= O_NONBLOCK;
+     fcntl(fromdns[0], F_SETFL, flags);
   }
-  resolvecount++;
 }
 
-
-void untieresolve(struct resolve *rp)
+int dns_waitfd (void)
 {
-  if (rp->previous)
-    rp->previous->next = rp->next;
-  else
-    expireresolves = rp->next;
-  if (rp->next)
-    rp->next->previous = rp->previous;
-  else
-    lastresolve = rp->previous;
-  resolvecount--;
+  return fromdns[0];
 }
 
 
-void unlinkresolve(struct resolve *rp)
-{
-  untieresolve(rp);
-  unlinkresolveid(rp);
-  unlinkresolveip(rp);
-  if (rp->hostname)
-    unlinkresolvehost(rp);
-}
 
-
-struct resolve *findid(word id)
+void dns_ack(void)
 {
-  struct resolve *rp;
-  int bashnum;
-
-  bashnum = getidbash(id);
-  rp = idbash[bashnum];
-  if (rp) {
-    while ((rp->nextid) && (id >= rp->nextid->id))
-      rp = rp->nextid;
-    while ((rp->previousid) && (id <= rp->previousid->id))
-      rp = rp->previousid;
-    if (id == rp->id) {
-      idbash[bashnum] = rp;
-      return rp;
-    } else
-      return NULL;
-  }
-  return rp; /* NULL */
-}
+  char buf[2048], host[NI_MAXHOST], name[NI_MAXHOST];  
+  ip_t hostip; 
+  struct dns_results *r;
 
+  while ( fgets (buf, sizeof (buf),  fromdnsfp )) {
+    sscanf (buf, "%s %s", host, name);
 
-struct resolve *findhost(char *hostname)
-{
-  struct resolve *rp;
-  int bashnum;
-
-  bashnum = gethostbash(hostname);
-  rp = hostbash[bashnum];
-  if (rp) {
-    while ((rp->nexthost) && (strcasecmp(hostname,rp->nexthost->hostname) >= 0))
-      rp = rp->nexthost;
-    while ((rp->previoushost) && (strcasecmp(hostname,rp->nexthost->hostname) <= 0))
-      rp = rp->previoushost;
-    if (strcasecmp(hostname,rp->hostname))
-      return NULL;
-    else {
-      hostbash[bashnum] = rp;
-      return rp;
-    }
+    longipstr (host, &hostip, af);
+    r = findip (&hostip);
+    if (r)  
+      r->name = strdup (name);
+    else 
+      fprintf (stderr, "dns_ack: Couldn't find host %s\n", host);
   }
-  return rp; /* NULL */
 }
 
 
-struct resolve *findip(ip_t * ip)
-{
-  struct resolve *rp;
-  dword bashnum;
-
-  bashnum = getipbash(ip);
-  rp = ipbash[bashnum];
-  if (rp) {
-    while ((rp->nextip) &&
-	   ( addrcmp( (void *) ip, (void *) &(rp->nextip->ip), af ) >= 0 ))
-      rp = rp->nextip;
-    while ((rp->previousip) &&
-           ( addrcmp( (void *) ip, (void *) &(rp->previousip->ip), af ) <= 0 ))
-      rp = rp->previousip;
-    if ( addrcmp( (void *) ip, (void *) &(rp->ip), af ) == 0 ) {
-      ipbash[bashnum] = rp;
-      return rp;
-    } else
-      return NULL;
-  }
-  return rp; /* NULL */
-}
-
 
-void restell(char *s)
-{
-  fputs(s,stderr);
-  fputs("\r",stderr);
-}
-
-
-void dorequest(char *s,int type,word id)
-{
-  packetheader *hp;
-  int r,i;
-  unsigned char buf[MaxPacketsize];
-
-  r = RES_MKQUERY(QUERY,s,C_IN,type,NULL,0,NULL,(unsigned char*)buf,MaxPacketsize);
-  if (r == -1) {
-    restell("Resolver error: Query too large.");
-    return;
-  }
-  hp = (packetheader *)buf;
-  hp->id = id;	/* htons() deliberately left out (redundant) */
-  for (i = 0;i < myres.nscount;i++)
-    if (myres.nsaddr_list[i].sin_family == AF_INET)
-      (void)sendto(resfd,buf,r,0,(struct sockaddr *)&myres.nsaddr_list[i],
-		   sizeof(struct sockaddr));
 #ifdef ENABLE_IPV6
-    else if (resfd6 > 0) {
-      if (!NSSOCKADDR6(i))
-	continue;
-      if (NSSOCKADDR6(i)->sin6_family == AF_INET6)
-	(void)sendto(resfd6,buf,r,0,(struct sockaddr *) NSSOCKADDR6(i),
-		     sizeof(struct sockaddr_in6));
-    }
-#endif
-}
-
-void resendrequest(struct resolve *rp,int type)
-{
-  if (type == T_A) {
-    dorequest(rp->hostname,type,rp->id);
-    if (debug) {
-      snprintf(tempstring, sizeof(tempstring), "Resolver: Sent reverse authentication request for \"%s\".",
-	      rp->hostname);
-      restell(tempstring);
-    }
-  } else if (type == T_PTR) {
-    switch ( af ) {
-    case AF_INET:
-    sprintf(tempstring,"%u.%u.%u.%u.in-addr.arpa",
-	    ((byte *)&rp->ip)[3],
-	    ((byte *)&rp->ip)[2],
-	    ((byte *)&rp->ip)[1],
-	    ((byte *)&rp->ip)[0]);
-      break;
-#ifdef ENABLE_IPV6
-    case AF_INET6:
-      addr2ip6arpa( &(rp->ip), tempstring );
-      break;
-#endif
-    }
-    dorequest(tempstring,type,rp->id);
-    if (debug) {
-      snprintf(tempstring, sizeof(tempstring), "Resolver: Sent domain lookup request for \"%s\".",
-	      strlongip( &(rp->ip) ));
-      restell(tempstring);
-    }
-  }
-}
 
-void sendrequest(struct resolve *rp,int type)
+int dns_waitfd6 (void)
 {
-  do {
-    idseed = (((idseed + idseed) | (long)time(NULL)) + idseed - 0x54bad4a) ^ aseed;
-    aseed^= idseed;
-    rp->id = (word)idseed;
-  } while (findid(rp->id));
-  linkresolveid(rp);
-  resendrequest(rp,type);
+  return  -1;
 }
 
-
-void failrp(struct resolve *rp)
-{
-  if (rp->state == STATE_FINISHED)
-    return;
-  rp->state = STATE_FAILED;
-  untieresolve(rp);
-  if (debug)
-    restell("Resolver: Lookup failed.\n");
-}
-
-
-void passrp(struct resolve *rp,long ttl)
+void dns_ack6(void)
 {
-  rp->state = STATE_FINISHED;
-  rp->expiretime = sweeptime + (double)ttl;
-  untieresolve(rp);
-  if (debug) {
-    snprintf(tempstring, sizeof(tempstring), "Resolver: Lookup successful: %s\n",rp->hostname);
-    restell(tempstring);
-  }
+  return;
 }
 
-
-void parserespacket(byte *s, int l)
-{
-  struct resolve *rp;
-  packetheader *hp;
-  byte *eob;
-  byte *c;
-  long ttl;
-  int r,usefulanswer;
-  word rr,datatype,class,qdatatype,qclass;
-  byte rdatalength;
-
-  if (l < (int) sizeof(packetheader)) {
-    restell("Resolver error: Packet smaller than standard header size.");
-    return;
-  }
-  if (l == (int) sizeof(packetheader)) {
-    restell("Resolver error: Packet has empty body.");
-    return;
-  }
-  hp = (packetheader *)s;
-  /* Convert data to host byte order */
-  /* hp->id does not need to be redundantly byte-order flipped, it is only echoed by nameserver */
-  rp = findid(hp->id);
-  if (!rp) {
-    res_unknownid++;
-    return;
-  }
-  if ((rp->state == STATE_FINISHED) || (rp->state == STATE_FAILED))
-    return;
-  hp->qdcount = ntohs(hp->qdcount);
-  hp->ancount = ntohs(hp->ancount);
-  hp->nscount = ntohs(hp->nscount);
-  hp->arcount = ntohs(hp->arcount);
-  if (getheader_tc(hp)) { /* Packet truncated */
-    restell("Resolver error: Nameserver packet truncated.");
-    return;
-  }
-  if (!getheader_qr(hp)) { /* Not a reply */
-    restell("Resolver error: Query packet received on nameserver communication socket.");
-    return;
-  }
-  if (getheader_opcode(hp)) { /* Not opcode 0 (standard query) */
-    restell("Resolver error: Invalid opcode in response packet.");
-    return;
-  }
-  eob = s + l;
-  c = s + HFIXEDSZ;
-  switch (getheader_rcode(hp)) {
-  case NOERROR:
-    if (hp->ancount) {
-      if (debug) {
-	snprintf(tempstring, sizeof(tempstring), "Resolver: Received nameserver reply. (qd:%u an:%u ns:%u ar:%u)",
-                hp->qdcount,hp->ancount,hp->nscount,hp->arcount);
-	restell(tempstring);
-      }
-      if (hp->qdcount != 1) {
-	restell("Resolver error: Reply does not contain one query.");
-	return;
-      }
-      if (c > eob) {
-	restell("Resolver error: Reply too short.");
-	return;
-      }
-      switch (rp->state) { /* Construct expected query reply */
-      case STATE_PTRREQ1:
-      case STATE_PTRREQ2:
-      case STATE_PTRREQ3:
-        switch ( af ) {
-        case AF_INET:
-	sprintf(stackstring,"%u.%u.%u.%u.in-addr.arpa",
-		((byte *)&rp->ip)[3],
-		((byte *)&rp->ip)[2],
-		((byte *)&rp->ip)[1],
-		((byte *)&rp->ip)[0]);
-	break;
-#ifdef ENABLE_IPV6
-        case AF_INET6:
-          addr2ip6arpa( &(rp->ip), stackstring );
-          break;
 #endif
-        }
-      }
-      *namestring = '\0';
-      r = dn_expand(s,s + l,c,namestring,MAXDNAME);
-      if (r == -1) {
-	restell("Resolver error: dn_expand() failed while expanding query domain.");
-	return;
-      }
-      namestring[strlen(stackstring)] = '\0';
-      if (strcasecmp(stackstring,namestring)) {
-	if (debug) {
-	  snprintf(tempstring, sizeof(tempstring), "Resolver: Unknown query packet dropped. (\"%s\" does not match \"%s\")",
-		  stackstring,namestring);
-	  restell(tempstring);
-	}
-	return;
-      }
-      if (debug) {
-	snprintf(tempstring, sizeof(tempstring), "Resolver: Queried domain name: \"%s\"",namestring);
-	restell(tempstring);
-      }
-      c+= r;
-      if (c + 4 > eob) {
-	restell("Resolver error: Query resource record truncated.");
-	return;
-      }
-      qdatatype = sucknetword(c);
-      qclass = sucknetword(c);
-      if (qclass != C_IN) {
-	snprintf(tempstring, sizeof(tempstring), "Resolver error: Received unsupported query class: %u (%s)",
-                qclass,qclass < ClasstypeCount ? classtypes[qclass] :
-		classtypes[ClasstypeCount]);
-	restell(tempstring);
-      }
-      switch (qdatatype) {
-      case T_PTR:
-	if (!Is_PTR(rp))
-	  if (debug) {
-	    restell("Resolver warning: Ignoring response with unexpected query type \"PTR\".");
-	    return;
-	  }
-	break;
-      default:
-	snprintf(tempstring, sizeof(tempstring), "Resolver error: Received unimplemented query type: %u (%s)",
-		qdatatype,qdatatype < ResourcetypeCount ?
-		resourcetypes[qdatatype] : resourcetypes[ResourcetypeCount]);
-	restell(tempstring);
-      }
-      for (rr = hp->ancount + hp->nscount + hp->arcount;rr;rr--) {
-	if (c > eob) {
-	  restell("Resolver error: Packet does not contain all specified resource records.");
-	  return;
-	}
-	*namestring = '\0';
-	r = dn_expand(s,s + l,c,namestring,MAXDNAME);
-	if (r == -1) {
-	  restell("Resolver error: dn_expand() failed while expanding answer domain.");
-	  return;
-	}
-	namestring[strlen(stackstring)] = '\0';
-	if (strcasecmp(stackstring,namestring))
-	  usefulanswer = 0;
-	else
-	  usefulanswer = 1;
-	if (debug) {
-	  snprintf(tempstring, sizeof(tempstring), "Resolver: answered domain query: \"%s\"",namestring);
-	  restell(tempstring);
-	}
-	c+= r;
-	if (c + 10 > eob) {
-	  restell("Resolver error: Resource record truncated.");
-	  return;
-	}
-	datatype = sucknetword(c);
-	class = sucknetword(c);
-	ttl = sucknetlong(c);
-	rdatalength = sucknetword(c);
-	if (class != qclass) {
-	  snprintf(tempstring, sizeof(tempstring), "query class: %u (%s)",qclass,qclass < ClasstypeCount ?
-		  classtypes[qclass] : classtypes[ClasstypeCount]);
-	  restell(tempstring);
-	  snprintf(tempstring, sizeof(tempstring), "rr class: %u (%s)",class,class < ClasstypeCount ?
-		  classtypes[class] : classtypes[ClasstypeCount]);
-	  restell(tempstring);
-	  restell("Resolver error: Answered class does not match queried class.");
-	  return;
-	}
-	if (!rdatalength) {
-	  restell("Resolver error: Zero size rdata.");
-	  return;
-	}
-	if (c + rdatalength > eob) {
-	  restell("Resolver error: Specified rdata length exceeds packet size.");
-	  return;
-	}
-	if (datatype == qdatatype || datatype == T_CNAME) {
-	  if (debug) {
-	    snprintf(tempstring, sizeof(tempstring), "Resolver: TTL: %s",strtdiff(sendstring,ttl));
-	    restell(tempstring);
-	  }
-	  if (usefulanswer)
-	    switch (datatype) {
-	    case T_A:
-	      if (rdatalength != 4) {
-		snprintf(tempstring, sizeof(tempstring), "Resolver error: Unsupported rdata format for \"A\" type. (%u bytes)",
-			rdatalength);
-		restell(tempstring);
-		return;
-	      }
-	      if ( addrcmp( (void *) &(rp->ip), (void *) c, af ) == 0 ) {
-		snprintf(tempstring, sizeof(tempstring), "Resolver: Reverse authentication failed: %s != ",
-			strlongip( &(rp->ip) ));
-		addrcpy( (void *) &alignedip, (void *) c, af );
-		strcat(tempstring,strlongip( &alignedip ));
-		restell(tempstring);
-		res_hostipmismatch++;
-		failrp(rp);
-	      } else {
-		snprintf(tempstring, sizeof(tempstring), "Resolver: Reverse authentication complete: %s == \"%s\".",
-			strlongip( &(rp->ip) ),nonull(rp->hostname));
-		restell(tempstring);
-		res_reversesuccess++;
-		passrp(rp,ttl);
-		return;
-	      }
-	      break;
-	    case T_PTR:
-	    case T_CNAME:
-	      *namestring = '\0';
-	      r = dn_expand(s,s + l,c,namestring,MAXDNAME);
-	      if (r == -1) {
-		restell("Resolver error: dn_expand() failed while expanding domain in rdata.");
-		return;
-	      }
-	      if (debug) {
-		snprintf(tempstring, sizeof(tempstring), "Resolver: Answered domain: \"%s\"",namestring);
-		restell(tempstring);
-	      }
-	      if (r > HostnameLength) {
-		restell("Resolver error: Domain name too long.");
-		failrp(rp);
-		return;
-	      }
-	      if (datatype == T_CNAME) {
-		strcpy(stackstring,namestring);
-		break;
-	      }
-	      if (!rp->hostname) {
-		rp->hostname = (char *)statmalloc(strlen(namestring) + 1);
-		if (!rp->hostname) {
-		  fprintf(stderr,"statmalloc() error: %s\n",strerror(errno));
-		  exit(-1);
-		}
-		strcpy(rp->hostname,namestring);
-		linkresolvehost(rp);
-		passrp(rp,ttl);
-		res_iplookupsuccess++;
-	      }
-	      break;
-	    default:
-	      snprintf(tempstring, sizeof(tempstring), "Resolver error: Received unimplemented data type: %u (%s)",
-		      datatype,datatype < ResourcetypeCount ?
-		      resourcetypes[datatype] : resourcetypes[ResourcetypeCount]);
-	      restell(tempstring);
-	    }
-	} else {
-	  if (debug) {
-	    snprintf(tempstring, sizeof(tempstring), "Resolver: Ignoring resource type %u. (%s)",
-		    datatype,datatype < ResourcetypeCount ?
-		    resourcetypes[datatype] : resourcetypes[ResourcetypeCount]);
-	    restell(tempstring);
-	  }
-	}
-	c+= rdatalength;
-      }
-    } else
-      restell("Resolver error: No error returned but no answers given.");
-    break;
-  case NXDOMAIN:
-    if (debug)
-      restell("Resolver: Host not found.");
-    res_nxdomain++;
-    failrp(rp);
-    break;
-  default:
-    snprintf(tempstring, sizeof(tempstring), "Resolver: Received error response %u. (%s)",
-	    getheader_rcode(hp),getheader_rcode(hp) < ResponsecodeCount ?
-	    responsecodes[getheader_rcode(hp)] : responsecodes[ResponsecodeCount]);
-    restell(tempstring);
-    res_nserror++;
-  }
-}
 
 
-void dns_ack(void)
-{
-  int r,i;
-
-  r = recvfrom(resfd,(byte *)resrecvbuf,MaxPacketsize,0,
-               from, &fromlen);
-  if (r > 0) {
-    /* Check to see if this server is actually one we sent to */
-    if ( addrcmp( (void *) &(from4->sin_addr), (void *) &localhost,
-                  (int) AF_INET ) == 0 ) {
-      for (i = 0;i < myres.nscount;i++)
-	if ( addrcmp( (void *) &(myres.nsaddr_list[i].sin_addr),
-		      (void *) &(from4->sin_addr), (int) AF_INET ) == 0 ||
-	     addrcmp( (void *) &(myres.nsaddr_list[i].sin_addr),
-		      (void *) &unspec_addr, (int) AF_INET ) == 0 )	/* 0.0.0.0 replies as 127.0.0.1 */
-	  break;
-    } else
-      for (i = 0;i < myres.nscount;i++)
-	if ( addrcmp( (void *) &(myres.nsaddr_list[i].sin_addr),
-		      (void *) &(from4->sin_addr), AF_INET ) == 0 )
-	  break;
-    if (i == myres.nscount) {
-      snprintf(tempstring, sizeof(tempstring), "Resolver error: Received reply from unknown source: %s",
-	      inet_ntoa(from4->sin_addr ));
-      restell(tempstring);
-    } else
-      parserespacket((byte *)resrecvbuf,r);
-  } else {
-    snprintf(tempstring, sizeof(tempstring), "Resolver: Socket error: %s",strerror(errno));
-    restell(tempstring);
-  }
-}
-#ifdef ENABLE_IPV6
-void dns_ack6(void)
+char *dns_lookup2(ip_t * ip)
 {
-  int r,i;
-  static char addrstr[INET6_ADDRSTRLEN];
-
-  // Probably not necessary. -- REW
-  if (resfd6 < 0) return; 
-
-  r = recvfrom(resfd6,(byte *)resrecvbuf,MaxPacketsize,0,
-               from, &fromlen);
-  if (r > 0) {
-    /* Check to see if this server is actually one we sent to */
-    if ( addrcmp( (void *) &(from6->sin6_addr), (void *) &localhost6,
-                  (int) AF_INET6 ) == 0 ) {
-      for (i = 0;i < myres.nscount;i++) {
-        if (!NSSOCKADDR6(i))
-          continue;
-
-	if ( addrcmp( (void *) &(NSSOCKADDR6(i)->sin6_addr),
-		      (void *) &(from6->sin6_addr), (int) AF_INET6 ) == 0 ||
-	     addrcmp( (void *) &(NSSOCKADDR6(i)->sin6_addr),
-		      (void *) &unspec_addr, (int) AF_INET6 ) == 0 )	/* 0.0.0.0 replies as 127.0.0.1 */
-	  break;
-      }
-    } else
-      for (i = 0;i < myres.nscount;i++) {
-        if (!NSSOCKADDR6(i))
-          continue;
-	if ( addrcmp( (void *) &(NSSOCKADDR6(i)->sin6_addr),
-		      (void *) &(from6->sin6_addr), AF_INET6 ) == 0 )
-	  break;
-      }
-    if (i == myres.nscount) {
-      snprintf(tempstring, sizeof(tempstring), 
-	       "Resolver error: Received reply from unknown source: %s",
-	       inet_ntop( AF_INET6, &(from6->sin6_addr), addrstr,
-			  sizeof addrstr ));
-      restell(tempstring);
-    } else
-      parserespacket((byte *)resrecvbuf,r);
+  struct dns_results *r;
+  char buf[INET6_ADDRSTRLEN + 1];
+  int rv;
+   
+  r = findip (ip);
+  if (r) {
+     // we've got a result. 
+     if (r->name) 
+        return r->name;
+     else
+        return strlongip (ip);
   } else {
-    snprintf(tempstring, sizeof(tempstring), "Resolver: Socket error: %s",strerror(errno));
-    restell(tempstring);
-  }
-}
-#endif
+     r = malloc (sizeof (struct dns_results));
+     //r->ip = *ip;
+     memcpy (&r->ip, ip, sizeof (r->ip));
+     r->name = NULL;
+     r->next = results;
+     results = r;
 
+     //printf ("lookup: %s\n", strlongip (ip));
 
-int istime(double x,double *sinterval)
-{
-  if (x) {
-    if (x > sweeptime) {
-      if (*sinterval > x - sweeptime)
-	*sinterval = x - sweeptime;
-    } else
-      return 1;
+     sprintf (buf, "%s\n", strlongip (ip));
+     rv = write  (todns[1], buf, strlen (buf));
+     if (rv < 0) perror ("couldn't write to resolver process");
   }
-  return 0;
+  return strlongip (ip);
 }
 
 
 void dns_events(double *sinterval)
 {
-  struct resolve *rp,*nextrp;
-
-  for (rp = expireresolves;(rp) && (sweeptime >= rp->expiretime);rp = nextrp) {
-    nextrp = rp->next;
-    switch (rp->state) {
-    case STATE_FINISHED:	/* TTL has expired */
-    case STATE_FAILED:	/* Fake TTL has expired */
-      if (debug) {
-	snprintf(tempstring, sizeof(tempstring), "Resolver: Cache record for \"%s\" (%s) has expired. (state: %u)  Marked for expire at: %g, time: %g.",
-                nonull(rp->hostname), strlongip( &(rp->ip) ), 
-		rp->state, rp->expiretime, sweeptime);
-	restell(tempstring);
-      }
-      unlinkresolve(rp);
-      break;
-    case STATE_PTRREQ1:	/* First T_PTR send timed out */
-      resendrequest(rp,T_PTR);
-      restell("Resolver: Send #2 for \"PTR\" query...");
-      rp->state++;
-      rp->expiretime = sweeptime + ResRetryDelay2;
-      (void)istime(rp->expiretime,sinterval);
-      res_resend++;
-      break;
-    case STATE_PTRREQ2:	/* Second T_PTR send timed out */
-      resendrequest(rp,T_PTR);
-      restell("Resolver: Send #3 for \"PTR\" query...");
-      rp->state++;
-      rp->expiretime = sweeptime + ResRetryDelay3;
-      (void)istime(rp->expiretime,sinterval);
-      res_resend++;
-      break;
-    case STATE_PTRREQ3:	/* Third T_PTR timed out */
-      restell("Resolver: \"PTR\" query timed out.");
-      failrp(rp);
-      (void)istime(rp->expiretime,sinterval);
-      res_timeout++;
-      break;
-    }
-  }
-  if (expireresolves)
-    (void)istime(expireresolves->expiretime,sinterval);
-}
-
-
-char *dns_lookup2(ip_t * ip)
-{
-  struct resolve *rp;
-
-  if ((rp = findip(ip))) {
-    if ((rp->state == STATE_FINISHED) || (rp->state == STATE_FAILED)) {
-      if ((rp->state == STATE_FINISHED) && (rp->hostname)) {
-	if (debug) {
-	  snprintf(tempstring, sizeof(tempstring), "Resolver: Used cached record: %s == \"%s\".\n",
-		  strlongip(ip),rp->hostname);
-	  restell(tempstring);
-	}
-	return rp->hostname;
-      } else {
-	if (debug) {
-	  snprintf(tempstring, sizeof(tempstring), "Resolver: Used failed record: %s == ???\n",
-		  strlongip(ip));
-	  restell(tempstring);
-	}
-	return NULL;
-      }
-    }
-    return NULL;
-  }
-  if (debug)
-    fprintf(stderr,"Resolver: Added to new record.\n");
-  rp = allocresolve();
-  rp->state = STATE_PTRREQ1;
-  rp->expiretime = sweeptime + ResRetryDelay1;
-  addrcpy( (void *) &(rp->ip), (void *) ip, af );
-  linkresolve(rp);
-  addrcpy( (void *) &(rp->ip), (void *) ip, af );
-  linkresolveip(rp);
-  sendrequest(rp,T_PTR);
-  return NULL;
+  return;
 }
 
 
@@ -1474,22 +330,23 @@ char *dns_lookup(ip_t * ip)
   return (t && use_dns) ? t : NULL;
 }
 
+
+#if 0
+char *strlongip(ip_t * ip)
+{
 #ifdef ENABLE_IPV6
-/* Returns an ip6.arpa character string. */
-void addr2ip6arpa( ip_t * ip, char * buf ) {
-  unsigned char * p = (unsigned char *) ip;
-  char * b = buf;
-  int i;
-
-  for ( i = sizeof (struct in6_addr) - 1; i >= 0; i-- ) {
-        sprintf( b, "%x.%x.", p[i] % 16, p[i] >> 4 );
-        b += 4;
-  }
-  sprintf( b, "ip6.arpa" );
-  return;
+  static char addrstr[INET6_ADDRSTRLEN];
+
+  return (char *) inet_ntop( af, ip, addrstr, sizeof addrstr );
+#else
+  return inet_ntoa( *ip );
+#endif
 }
 #endif
 
+
+// XXX check if necessary/exported. 
+
 /* Resolve an IP address to a hostname. */ 
 struct hostent *addr2host( const char *addr, int af ) {
   int len = 0;
@@ -1505,3 +362,6 @@ struct hostent *addr2host( const char *addr, int af ) {
   }
   return gethostbyaddr( addr, len, af );
 }
+
+
+
diff --git a/mtr.8 b/mtr.8
index 8e41b8c..33f82d6 100644
--- a/mtr.8
+++ b/mtr.8
@@ -35,9 +35,6 @@ mtr \- a network diagnostic tool
 .B \-\-csv\c
 ]
 [\c
-.B \-\-json\c
-]
-[\c
 .B \-\-split\c
 ]
 [\c
@@ -68,9 +65,6 @@ mtr \- a network diagnostic tool
 .BI \-B \ BITPATTERN\c
 ]
 [\c
-.BI \-G \ GRACEPERIOD\c
-]
-[\c
 .BI \-Q \ TOS\c
 ]
 [\c
@@ -245,12 +239,6 @@ MTR.0.86+git:16e39fc0;1435562787;OK;nic.is;6;rix-k2-gw.isnic.is;1654
 MTR.0.86+git:16e39fc0;1435562787;OK;nic.is;7;www.isnic.is;1036
 .fi
 .TP
-.B \-j\fR, \fB\-\-json
-Use this option to tell
-.B mtr
-to use the JSON output format.  This format is better suited for
-automated processing of the measurement results.
-.TP
 .B \-p\fR, \fB\-\-split
 Use this option to set
 .B mtr 
@@ -349,10 +337,6 @@ Specifies bit pattern to use in payload.  Should be within range 0 - 255.  If
 .I NUM
 is greater than 255, a random pattern is used.
 .TP
-.B \-G \fISECONDS\fR, \fB\-\-graceperiod \fISECONDS
-Use this option to specify the positive number of seconds to wait for responses
-after the final request. The default value is five seconds.
-.TP
 .B \-Q \fINUM\fR, \fB\-\-tos \fINUM
 Specifies value for type of service field in IP header.  Should be within range 0
 - 255.
diff --git a/mtr.c b/mtr.c
index d748412..2e1c630 100644
--- a/mtr.c
+++ b/mtr.c
@@ -67,7 +67,6 @@ int   PrintHelp = 0;
 int   MaxPing = 10;
 int   ForceMaxPing = 0;
 float WaitTime = 1.0;
-float GraceTime = 5.0;
 char *Hostname = NULL;
 char *InterfaceAddress = NULL;
 char  LocalHostname[128];
@@ -285,7 +284,6 @@ void parse_arg (int argc, char **argv)
     { "gtk",            0, NULL, 'g' },
     { "raw",            0, NULL, 'l' },
     { "csv",            0, NULL, 'C' },
-    { "json",           0, NULL, 'j' },
     { "displaymode",    1, NULL, 'd' },
     { "split",          0, NULL, 'p' }, /* BL */
                                         /* maybe above should change to -d 'x' */
@@ -314,7 +312,6 @@ void parse_arg (int argc, char **argv)
     { "port",           1, NULL, 'P' }, /* target port number for TCP/SCTP/UDP */
     { "localport",      1, NULL, 'L' }, /* source port number for UDP */
     { "timeout",        1, NULL, 'Z' }, /* timeout for TCP sockets */
-    { "gracetime",      1, NULL, 'G' }, /* graceperiod for replies after last probe */
 #ifdef SO_MARK
     { "mark",           1, NULL, 'M' }, /* use SO_MARK */
 #endif
@@ -324,7 +321,7 @@ void parse_arg (int argc, char **argv)
   opt = 0;
   while(1) {
     opt = getopt_long(argc, argv,
-		      "hv46F:rwxtglCjpnbo:y:zi:c:s:B:Q:ea:f:m:U:uTSP:L:Z:G:M:", long_options, NULL);
+		      "hv46F:rwxtglCpnbo:y:zi:c:s:B:Q:ea:f:m:U:uTSP:L:Z:M:", long_options, NULL);
     if(opt == -1)
       break;
 
@@ -358,9 +355,6 @@ void parse_arg (int argc, char **argv)
     case 'C':
       DisplayMode = DisplayCSV;
       break;
-    case 'j':
-      DisplayMode = DisplayJSON;
-      break;
     case 'x':
       DisplayMode = DisplayXML;
       break;
@@ -444,13 +438,6 @@ void parse_arg (int argc, char **argv)
       if (bitpattern > 255)
 	bitpattern = -1;
       break;
-    case 'G':
-      GraceTime = atof (optarg);
-      if (GraceTime <= 0.0) {
-        fprintf (stderr, "mtr: wait time must be positive\n");
-        exit (1);
-      }
-      break;
     case 'Q':
       tos = atoi (optarg);
       if (tos > 255 || tos < 0) {
@@ -550,7 +537,6 @@ void parse_arg (int argc, char **argv)
 
   if (DisplayMode == DisplayReport ||
       DisplayMode == DisplayTXT ||
-      DisplayMode == DisplayJSON ||
       DisplayMode == DisplayXML ||
       DisplayMode == DisplayRaw ||
       DisplayMode == DisplayCSV)
@@ -650,13 +636,13 @@ int main(int argc, char **argv)
   if (PrintHelp) {
        printf("usage: %s [--help] [--version] [-4|-6] [-F FILENAME]\n"
               "\t\t[--report] [--report-wide] [--displaymode MODE]\n"
-              "\t\t[--xml] [--gtk] [--curses] [--raw] [--csv] [--json] [--split]\n"
+              "\t\t[--xml] [--gtk] [--curses] [--raw] [--csv] [--split]\n"
               "\t\t[--no-dns] [--show-ips] [-o FIELDS] [-y IPINFO] [--aslookup]\n"
               "\t\t[-i INTERVAL] [-c COUNT] [-s PACKETSIZE] [-B BITPATTERN]\n"
               "\t\t[-Q TOS] [--mpls]\n"
               "\t\t[-a ADDRESS] [-f FIRST-TTL] [-m MAX-TTL] [-U MAX_UNKNOWN]\n"
               "\t\t[--udp] [--tcp] [--sctp] [-P PORT] [-L LOCALPORT] [-Z TIMEOUT]\n"
-              "\t\t[-G GRACEPERIOD] [-M MARK] HOSTNAME\n", argv[0]);
+              "\t\t[-M MARK] HOSTNAME\n", argv[0]);
        printf("See the man page for details.\n");
     exit(0);
   }
diff --git a/report.c b/report.c
index b47a855..e0a9548 100644
--- a/report.c
+++ b/report.c
@@ -253,104 +253,11 @@ void txt_open(void)
 
 
 void txt_close(void)
-{
+{ 
   report_close();
 }
 
 
-void json_open(void)
-{
-}
-
-
-void json_close(void)
-{
-  int i, j, at, first, max;
-  ip_t *addr;
-  char name[81];
-
-  printf("{\n");
-  printf("  \"report\": {\n");
-  printf("    \"mtr\": {\n");
-  printf("      \"src\": \"%s\",\n", LocalHostname);
-  printf("      \"dst\": \"%s\",\n", Hostname);
-  printf("      \"tos\": \"0x%X\",\n", tos);
-  if(cpacketsize >= 0) {
-    printf("      \"psize\": \"%d\",\n", cpacketsize);
-  } else {
-    printf("      \"psize\": \"rand(%d-%d)\",\n",MINPACKET, -cpacketsize);
-  }
-  if( bitpattern>=0 ) {
-    printf("      \"bitpattern\": \"0x%02X\",\n", (unsigned char)(bitpattern));
-  } else {
-    printf("      \"bitpattern\": \"rand(0x00-FF)\",\n");
-  }
-  printf("      \"tests\": \"%d\"\n", MaxPing);
-  printf("    },\n");
-
-  printf("    \"hubs\": [");
-
-  max = net_max();
-  at = first = net_min();
-  for(; at < max; at++) {
-    addr = net_addr(at);
-    snprint_addr(name, sizeof(name), addr);
-
-    if(at == first) {
-      printf("{\n");
-    } else {
-      printf("    {\n");
-    }
-    printf("      \"count\": \"%d\",\n", at+1);
-    printf("      \"host\": \"%s\",\n", name);
-    for( i=0; i<MAXFLD; i++ ) {
-      j = fld_index[fld_active[i]];
-
-      /* Commas */
-      if(i + 1 == MAXFLD) {
-        printf("\n");
-      } else if (j > 0 && i != 0) {
-        printf(",\n");
-      }
-
-      if (j <= 0) continue; // Field nr 0, " " shouldn't be printed in this method.
-
-      /* Format value */
-      const char *format;
-      format = data_fields[j].format;
-      if( index(format, 'f') ) {
-        format = "%.2f";
-      } else {
-        format = "%d";
-      }
-
-      /* Format json line */
-      strcpy(name, "      \"%s\": ");
-      strcat(name, format);
-
-      /* Output json line */
-      if(index(data_fields[j].format, 'f')) {
-        /* 1000.0 is a temporay hack for stats usec to ms, impacted net_loss. */
-        printf(name,
-               data_fields[j].title,
-               data_fields[j].net_xxx(at) / 1000.0);
-      } else {
-        printf(name,
-               data_fields[j].title,
-               data_fields[j].net_xxx(at));
-      }
-    }
-    if(at+1 == max) {
-      printf("    }]\n");
-    } else {
-      printf("    },\n");
-    }
-  }
-  printf("  }\n");
-  printf("}\n");
-}
-
-
 
 void xml_open(void)
 {
diff --git a/report.h b/report.h
index 566be3e..81c2d81 100644
--- a/report.h
+++ b/report.h
@@ -22,8 +22,6 @@ void report_open(void);
 void report_close(void);
 void txt_open(void);
 void txt_close(void);
-void json_open(void);
-void json_close(void);
 void xml_open(void);
 void xml_close(void);
 void csv_open(void);
diff --git a/select.c b/select.c
index ed0ae5e..b2c4349 100644
--- a/select.c
+++ b/select.c
@@ -39,14 +39,14 @@ extern int Interactive;
 extern int MaxPing;
 extern int ForceMaxPing;
 extern float WaitTime;
-extern float GraceTime;
 double dnsinterval;
 extern int mtrtype;
 
 static struct timeval intervaltime;
 int display_offset = 0;
 
-#define GRACETIME (GraceTime * 1000*1000)
+
+#define GRACETIME (5 * 1000*1000)
 
 void select_loop(void) {
   fd_set readfd;
