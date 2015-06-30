--- iptables-1.4.21/include/libiptc/ipt_kernel_headers.h	Fri Nov 22 12:18:13 2013
+++ iptables-1.4.21-patched/include/libiptc/ipt_kernel_headers.h	Sun Oct 12 11:05:27 2014
@@ -5,7 +5,6 @@
 
 #include <limits.h>
 
-#if defined(__GLIBC__) && __GLIBC__ == 2
 #include <netinet/ip.h>
 #include <netinet/in.h>
 #include <netinet/ip_icmp.h>
@@ -13,15 +12,5 @@
 #include <netinet/udp.h>
 #include <net/if.h>
 #include <sys/types.h>
-#else /* libc5 */
-#include <sys/socket.h>
-#include <linux/ip.h>
-#include <linux/in.h>
-#include <linux/if.h>
-#include <linux/icmp.h>
-#include <linux/tcp.h>
-#include <linux/udp.h>
-#include <linux/types.h>
-#include <linux/in6.h>
-#endif
+
 #endif
--- iptables-1.4.21/include/linux/netfilter_ipv4/ip_tables.h	Fri Nov 22 12:18:13 2013
+++ iptables-1.4.21-patched/include/linux/netfilter_ipv4/ip_tables.h	Sun Oct 12 11:07:09 2014
@@ -15,6 +15,8 @@
 #ifndef _IPTABLES_H
 #define _IPTABLES_H
 
+#include <inttypes.h>
+#include <net/if.h>
 #include <linux/types.h>
 
 #include <linux/netfilter_ipv4.h>
@@ -73,12 +75,12 @@
 	unsigned char iniface_mask[IFNAMSIZ], outiface_mask[IFNAMSIZ];
 
 	/* Protocol, 0 = ANY */
-	u_int16_t proto;
+	uint16_t proto;
 
 	/* Flags word */
-	u_int8_t flags;
+	uint8_t flags;
 	/* Inverse flags */
-	u_int8_t invflags;
+	uint8_t invflags;
 };
 
 /* Values for "flag" field in struct ipt_ip (general ip structure). */
@@ -106,9 +108,9 @@
 	unsigned int nfcache;
 
 	/* Size of ipt_entry + matches */
-	u_int16_t target_offset;
+	uint16_t target_offset;
 	/* Size of ipt_entry + matches + target */
-	u_int16_t next_offset;
+	uint16_t next_offset;
 
 	/* Back pointer */
 	unsigned int comefrom;
@@ -141,9 +143,9 @@
 
 /* ICMP matching stuff */
 struct ipt_icmp {
-	u_int8_t type;				/* type to match */
-	u_int8_t code[2];			/* range of code */
-	u_int8_t invflags;			/* Inverse flags */
+	uint8_t type;				/* type to match */
+	uint8_t code[2];			/* range of code */
+	uint8_t invflags;			/* Inverse flags */
 };
 
 /* Values for "inv" field for struct ipt_icmp. */
--- iptables-1.4.21/include/linux/netfilter_ipv6/ip6_tables.h	Fri Nov 22 12:18:13 2013
+++ iptables-1.4.21-patched/include/linux/netfilter_ipv6/ip6_tables.h	Sun Oct 12 11:16:47 2014
@@ -73,14 +73,14 @@
 	 *   MH do not match any packets.
 	 * - You also need to set IP6T_FLAGS_PROTO to "flags" to check protocol.
 	 */
-	u_int16_t proto;
+	uint16_t proto;
 	/* TOS to match iff flags & IP6T_F_TOS */
-	u_int8_t tos;
+	uint8_t tos;
 
 	/* Flags word */
-	u_int8_t flags;
+	uint8_t flags;
 	/* Inverse flags */
-	u_int8_t invflags;
+	uint8_t invflags;
 };
 
 /* Values for "flag" field in struct ip6t_ip6 (general ip6 structure). */
@@ -110,9 +110,9 @@
 	unsigned int nfcache;
 
 	/* Size of ipt_entry + matches */
-	u_int16_t target_offset;
+	uint16_t target_offset;
 	/* Size of ipt_entry + matches + target */
-	u_int16_t next_offset;
+	uint16_t next_offset;
 
 	/* Back pointer */
 	unsigned int comefrom;
@@ -178,9 +178,9 @@
 
 /* ICMP matching stuff */
 struct ip6t_icmp {
-	u_int8_t type;				/* type to match */
-	u_int8_t code[2];			/* range of code */
-	u_int8_t invflags;			/* Inverse flags */
+	uint8_t type;				/* type to match */
+	uint8_t code[2];			/* range of code */
+	uint8_t invflags;			/* Inverse flags */
 };
 
 /* Values for "inv" field for struct ipt_icmp. */
--- iptables-1.4.21/include/xtables.h	Fri Nov 22 12:18:13 2013
+++ iptables-1.4.21-patched/include/xtables.h	Sun Oct 12 11:16:08 2014
@@ -18,6 +18,23 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/x_tables.h>
 
+# define TCPOPT_EOL                0
+# define TCPOPT_NOP                1
+# define TCPOPT_MAXSEG                2
+# define TCPOLEN_MAXSEG                4
+# define TCPOPT_WINDOW                3
+# define TCPOLEN_WINDOW                3
+# define TCPOPT_SACK_PERMITTED        4                /* Experimental */
+# define TCPOLEN_SACK_PERMITTED        2
+# define TCPOPT_SACK                5                /* Experimental */
+# define TCPOPT_TIMESTAMP        8
+# define TCPOLEN_TIMESTAMP        10
+# define TCPOLEN_TSTAMP_APPA        (TCPOLEN_TIMESTAMP+2) /* appendix A */
+
+# define TCPOPT_TSTAMP_HDR        \
+    (TCPOPT_NOP<<24|TCPOPT_NOP<<16|TCPOPT_TIMESTAMP<<8|TCPOLEN_TIMESTAMP)
+
+
 #ifndef IPPROTO_SCTP
 #define IPPROTO_SCTP 132
 #endif
