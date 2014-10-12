--- libnetfilter_conntrack-1.0.4/include/libnetfilter_conntrack/libnetfilter_conntrack.h	Tue Aug  6 15:22:55 2013
+++ libnetfilter_conntrack-1.0.4-patched/include/libnetfilter_conntrack/libnetfilter_conntrack.h	Sun Oct 12 12:51:58 2014
@@ -37,9 +37,9 @@
 /*
  * [Open|close] a conntrack handler
  */
-extern struct nfct_handle *nfct_open(u_int8_t, unsigned);
+extern struct nfct_handle *nfct_open(uint8_t, unsigned);
 extern struct nfct_handle *nfct_open_nfnl(struct nfnl_handle *nfnlh,
-					  u_int8_t subsys_id,
+					  uint8_t subsys_id,
 					  unsigned int subscriptions);
 extern int nfct_close(struct nfct_handle *cth);
 
@@ -173,7 +173,7 @@
 
 struct nfct_attr_grp_icmp {
 	u_int16_t id;
-	u_int8_t code, type;
+	uint8_t code, type;
 };
 
 struct nfct_attr_grp_ctrs {
@@ -302,7 +302,7 @@
 
 extern void nfct_set_attr_u8(struct nf_conntrack *ct,
 			     const enum nf_conntrack_attr type,
-			     u_int8_t value);
+			     uint8_t value);
 
 extern void nfct_set_attr_u16(struct nf_conntrack *ct,
 			      const enum nf_conntrack_attr type,
@@ -325,7 +325,7 @@
 extern const void *nfct_get_attr(const struct nf_conntrack *ct,
 				 const enum nf_conntrack_attr type);
 
-extern u_int8_t nfct_get_attr_u8(const struct nf_conntrack *ct,
+extern uint8_t nfct_get_attr_u8(const struct nf_conntrack *ct,
 				 const enum nf_conntrack_attr type);
 
 extern u_int16_t nfct_get_attr_u16(const struct nf_conntrack *ct,
@@ -531,7 +531,7 @@
 
 enum nfct_filter_dump_attr {
 	NFCT_FILTER_DUMP_MARK = 0,	/* struct nfct_filter_dump_mark */
-	NFCT_FILTER_DUMP_L3NUM,		/* u_int8_t */
+	NFCT_FILTER_DUMP_L3NUM,		/* uint8_t */
 	NFCT_FILTER_DUMP_MAX
 };
 
@@ -545,7 +545,7 @@
 
 void nfct_filter_dump_set_attr_u8(struct nfct_filter_dump *filter_dump,
 				  const enum nfct_filter_dump_attr type,
-				  u_int8_t data);
+				  uint8_t data);
 
 /* low level API: netlink functions */
 
@@ -640,7 +640,7 @@
 
 extern void nfexp_set_attr_u8(struct nf_expect *exp,
 			      const enum nf_expect_attr type,
-			      u_int8_t value);
+			      uint8_t value);
 
 extern void nfexp_set_attr_u16(struct nf_expect *exp,
 			       const enum nf_expect_attr type,
@@ -654,7 +654,7 @@
 extern const void *nfexp_get_attr(const struct nf_expect *exp,
 				  const enum nf_expect_attr type);
 
-extern u_int8_t nfexp_get_attr_u8(const struct nf_expect *exp,
+extern uint8_t nfexp_get_attr_u8(const struct nf_expect *exp,
 				  const enum nf_expect_attr type);
 
 extern u_int16_t nfexp_get_attr_u16(const struct nf_expect *exp,
--- libnetfilter_conntrack-1.0.4/src/main.c	Fri Dec 30 00:42:58 2011
+++ libnetfilter_conntrack-1.0.4-patched/src/main.c	Sun Oct 12 12:53:00 2014
@@ -7,6 +7,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <inttypes.h>
 #include <libnfnetlink/libnfnetlink.h>
 #include <libnetfilter_conntrack/libnetfilter_conntrack.h>
 
