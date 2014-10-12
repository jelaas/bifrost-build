--- libnfnetlink-1.0.1/include/libnfnetlink/libnfnetlink.h	Sun May  9 23:31:56 2010
+++ libnfnetlink-1.0.1-patched/include/libnfnetlink/libnfnetlink.h	Sun Oct 12 12:41:46 2014
@@ -55,7 +55,7 @@
 struct nfnl_callback {
 	int (*call)(struct nlmsghdr *nlh, struct nfattr *nfa[], void *data);
 	void *data;
-	u_int16_t attr_count;
+	uint16_t attr_count;
 };
 
 struct nfnl_handle;
@@ -69,7 +69,7 @@
 extern int nfnl_close(struct nfnl_handle *);
 
 extern struct nfnl_subsys_handle *nfnl_subsys_open(struct nfnl_handle *, 
-						   u_int8_t, u_int8_t, 
+						   uint8_t, uint8_t, 
 						   unsigned int);
 extern void nfnl_subsys_close(struct nfnl_subsys_handle *);
 
@@ -88,8 +88,8 @@
 			const struct iovec *iov, unsigned int num,
 			unsigned int flags);
 extern void nfnl_fill_hdr(struct nfnl_subsys_handle *, struct nlmsghdr *,
-			  unsigned int, u_int8_t, u_int16_t, u_int16_t,
-			  u_int16_t);
+			  unsigned int, uint8_t, uint16_t, uint16_t,
+			  uint16_t);
 extern __attribute__((deprecated)) int
 nfnl_talk(struct nfnl_handle *, struct nlmsghdr *, pid_t,
           unsigned, struct nlmsghdr *,
@@ -103,8 +103,8 @@
 /* receiving */
 extern ssize_t nfnl_recv(const struct nfnl_handle *h, unsigned char *buf, size_t len);
 extern int nfnl_callback_register(struct nfnl_subsys_handle *,
-				  u_int8_t type, struct nfnl_callback *cb);
-extern int nfnl_callback_unregister(struct nfnl_subsys_handle *, u_int8_t type);
+				  uint8_t type, struct nfnl_callback *cb);
+extern int nfnl_callback_unregister(struct nfnl_subsys_handle *, uint8_t type);
 extern int nfnl_handle_packet(struct nfnl_handle *, char *buf, int len);
 
 /* parsing */
@@ -180,12 +180,12 @@
 
 /* nfnl attribute handling functions */
 extern int nfnl_addattr_l(struct nlmsghdr *, int, int, const void *, int);
-extern int nfnl_addattr8(struct nlmsghdr *, int, int, u_int8_t);
-extern int nfnl_addattr16(struct nlmsghdr *, int, int, u_int16_t);
-extern int nfnl_addattr32(struct nlmsghdr *, int, int, u_int32_t);
+extern int nfnl_addattr8(struct nlmsghdr *, int, int, uint8_t);
+extern int nfnl_addattr16(struct nlmsghdr *, int, int, uint16_t);
+extern int nfnl_addattr32(struct nlmsghdr *, int, int, uint32_t);
 extern int nfnl_nfa_addattr_l(struct nfattr *, int, int, const void *, int);
-extern int nfnl_nfa_addattr16(struct nfattr *, int, int, u_int16_t);
-extern int nfnl_nfa_addattr32(struct nfattr *, int, int, u_int32_t);
+extern int nfnl_nfa_addattr16(struct nfattr *, int, int, uint16_t);
+extern int nfnl_nfa_addattr32(struct nfattr *, int, int, uint32_t);
 extern int nfnl_parse_attr(struct nfattr **, int, struct nfattr *, int);
 #define nfnl_parse_nested(tb, max, nfa) \
 	nfnl_parse_attr((tb), (max), NFA_DATA((nfa)), NFA_PAYLOAD((nfa)))
@@ -197,7 +197,7 @@
 ({	(tail)->nfa_len = (void *) NLMSG_TAIL(nlh) - (void *) tail; })
 
 extern void nfnl_build_nfa_iovec(struct iovec *iov, struct nfattr *nfa, 
-				 u_int16_t type, u_int32_t len,
+				 uint16_t type, uint32_t len,
 				 unsigned char *val);
 extern unsigned int nfnl_rcvbufsiz(const struct nfnl_handle *h, 
 				   unsigned int size);
--- libnfnetlink-1.0.1/include/libnfnetlink/linux_nfnetlink.h	Wed Jun 18 14:36:57 2008
+++ libnfnetlink-1.0.1-patched/include/libnfnetlink/linux_nfnetlink.h	Sun Oct 12 12:42:54 2014
@@ -25,9 +25,9 @@
 /* General form of address family dependent message.
  */
 struct nfgenmsg {
-	u_int8_t  nfgen_family;		/* AF_xxx */
-	u_int8_t  version;		/* nfnetlink version */
-	u_int16_t    res_id;		/* resource id */
+	uint8_t  nfgen_family;		/* AF_xxx */
+	uint8_t  version;		/* nfnetlink version */
+	uint16_t    res_id;		/* resource id */
 };
 
 #define NFNETLINK_V0	0
@@ -59,7 +59,7 @@
 	int (*call)(struct sock *nl, struct sk_buff *skb, 
 		struct nlmsghdr *nlh, struct nlattr *cda[]);
 	const struct nla_policy *policy;	/* netlink attribute policy */
-	const u_int16_t attr_count;		/* number of nlattr's */
+	const uint16_t attr_count;		/* number of nlattr's */
 };
 
 struct nfnetlink_subsystem
--- libnfnetlink-1.0.1/include/libnfnetlink/linux_nfnetlink_compat.h	Wed Jun 18 14:36:57 2008
+++ libnfnetlink-1.0.1-patched/include/libnfnetlink/linux_nfnetlink_compat.h	Sun Oct 12 12:42:12 2014
@@ -20,8 +20,8 @@
 
 struct nfattr
 {
-	u_int16_t nfa_len;
-	u_int16_t nfa_type;	/* we use 15 bits for the type, and the highest
+	uint16_t nfa_len;
+	uint16_t nfa_type;	/* we use 15 bits for the type, and the highest
 				 * bit to indicate whether the payload is nested */
 };
 
--- libnfnetlink-1.0.1/src/libnfnetlink.c	Mon Aug 13 19:56:29 2012
+++ libnfnetlink-1.0.1-patched/src/libnfnetlink.c	Sun Oct 12 12:43:51 2014
@@ -72,9 +72,9 @@
 
 struct nfnl_subsys_handle {
 	struct nfnl_handle 	*nfnlh;
-	u_int32_t		subscriptions;
-	u_int8_t		subsys_id;
-	u_int8_t		cb_count;
+	uint32_t		subscriptions;
+	uint8_t		subsys_id;
+	uint8_t		cb_count;
 	struct nfnl_callback 	*cb;	/* array of callbacks */
 };
 
@@ -86,11 +86,11 @@
 	int			fd;
 	struct sockaddr_nl	local;
 	struct sockaddr_nl	peer;
-	u_int32_t		subscriptions;
-	u_int32_t		seq;
-	u_int32_t		dump;
-	u_int32_t		rcv_buffer_size;	/* for nfnl_catch */
-	u_int32_t		flags;
+	uint32_t		subscriptions;
+	uint32_t		seq;
+	uint32_t		dump;
+	uint32_t		rcv_buffer_size;	/* for nfnl_catch */
+	uint32_t		flags;
 	struct nlmsghdr 	*last_nlhdr;
 	struct nfnl_subsys_handle subsys[NFNL_MAX_SUBSYS+1];
 };
@@ -145,7 +145,7 @@
 static int recalc_rebind_subscriptions(struct nfnl_handle *nfnlh)
 {
 	int i, err;
-	u_int32_t new_subscriptions = nfnlh->subscriptions;
+	uint32_t new_subscriptions = nfnlh->subscriptions;
 
 	for (i = 0; i < NFNL_MAX_SUBSYS; i++)
 		new_subscriptions |= nfnlh->subsys[i].subscriptions;
@@ -273,8 +273,8 @@
  * a valid address that points to a nfnl_subsys_handle structure is returned.
  */
 struct nfnl_subsys_handle *
-nfnl_subsys_open(struct nfnl_handle *nfnlh, u_int8_t subsys_id,
-		 u_int8_t cb_count, u_int32_t subscriptions)
+nfnl_subsys_open(struct nfnl_handle *nfnlh, uint8_t subsys_id,
+		 uint8_t cb_count, uint32_t subscriptions)
 {
 	struct nfnl_subsys_handle *ssh;
 
@@ -435,10 +435,10 @@
  */
 void nfnl_fill_hdr(struct nfnl_subsys_handle *ssh,
 		    struct nlmsghdr *nlh, unsigned int len, 
-		    u_int8_t family,
-		    u_int16_t res_id,
-		    u_int16_t msg_type,
-		    u_int16_t msg_flags)
+		    uint8_t family,
+		    uint16_t res_id,
+		    uint16_t msg_type,
+		    uint16_t msg_flags)
 {
 	assert(ssh);
 	assert(nlh);
@@ -848,14 +848,14 @@
 }
 
 /**
- * nfnl_addattr8 - Add u_int8_t attribute to nlmsghdr
+ * nfnl_addattr8 - Add uint8_t attribute to nlmsghdr
  *
  * @n: netlink message header to which attribute is to be added
  * @maxlen: maximum length of netlink message header
  * @type: type of new attribute
  * @data: content of new attribute
  */
-int nfnl_addattr8(struct nlmsghdr *n, int maxlen, int type, u_int8_t data)
+int nfnl_addattr8(struct nlmsghdr *n, int maxlen, int type, uint8_t data)
 {
 	assert(n);
 	assert(maxlen > 0);
@@ -865,7 +865,7 @@
 }
 
 /**
- * nfnl_nfa_addattr16 - Add u_int16_t attribute to struct nfattr 
+ * nfnl_nfa_addattr16 - Add uint16_t attribute to struct nfattr 
  *
  * @nfa: struct nfattr
  * @maxlen: maximal length of nfattr buffer
@@ -874,7 +874,7 @@
  *
  */
 int nfnl_nfa_addattr16(struct nfattr *nfa, int maxlen, int type, 
-		       u_int16_t data)
+		       uint16_t data)
 {
 	assert(nfa);
 	assert(maxlen > 0);
@@ -884,7 +884,7 @@
 }
 
 /**
- * nfnl_addattr16 - Add u_int16_t attribute to nlmsghdr
+ * nfnl_addattr16 - Add uint16_t attribute to nlmsghdr
  *
  * @n: netlink message header to which attribute is to be added
  * @maxlen: maximum length of netlink message header
@@ -893,7 +893,7 @@
  *
  */
 int nfnl_addattr16(struct nlmsghdr *n, int maxlen, int type,
-		   u_int16_t data)
+		   uint16_t data)
 {
 	assert(n);
 	assert(maxlen > 0);
@@ -903,7 +903,7 @@
 }
 
 /**
- * nfnl_nfa_addattr32 - Add u_int32_t attribute to struct nfattr 
+ * nfnl_nfa_addattr32 - Add uint32_t attribute to struct nfattr 
  *
  * @nfa: struct nfattr
  * @maxlen: maximal length of nfattr buffer
@@ -912,7 +912,7 @@
  *
  */
 int nfnl_nfa_addattr32(struct nfattr *nfa, int maxlen, int type, 
-		       u_int32_t data)
+		       uint32_t data)
 {
 	assert(nfa);
 	assert(maxlen > 0);
@@ -922,7 +922,7 @@
 }
 
 /**
- * nfnl_addattr32 - Add u_int32_t attribute to nlmsghdr
+ * nfnl_addattr32 - Add uint32_t attribute to nlmsghdr
  *
  * @n: netlink message header to which attribute is to be added
  * @maxlen: maximum length of netlink message header
@@ -931,7 +931,7 @@
  *
  */
 int nfnl_addattr32(struct nlmsghdr *n, int maxlen, int type,
-		   u_int32_t data)
+		   uint32_t data)
 {
 	assert(n);
 	assert(maxlen > 0);
@@ -979,7 +979,7 @@
  *
  */ 
 void nfnl_build_nfa_iovec(struct iovec *iov, struct nfattr *nfa, 
-			  u_int16_t type, u_int32_t len, unsigned char *val)
+			  uint16_t type, uint32_t len, unsigned char *val)
 {
 	assert(iov);
 	assert(nfa);
@@ -1114,7 +1114,7 @@
  * appropiately.
  */
 int nfnl_callback_register(struct nfnl_subsys_handle *ssh,
-			   u_int8_t type, struct nfnl_callback *cb)
+			   uint8_t type, struct nfnl_callback *cb)
 {
 	assert(ssh);
 	assert(cb);
@@ -1137,7 +1137,7 @@
  * On sucess, 0 is returned. On error, -1 is returned and errno is
  * set appropiately.
  */
-int nfnl_callback_unregister(struct nfnl_subsys_handle *ssh, u_int8_t type)
+int nfnl_callback_unregister(struct nfnl_subsys_handle *ssh, uint8_t type)
 {
 	assert(ssh);
 
@@ -1160,8 +1160,8 @@
 	assert(nfa);
 
 	int min_len;
-	u_int8_t type = NFNL_MSG_TYPE(nlh->nlmsg_type);
-	u_int8_t subsys_id = NFNL_SUBSYS_ID(nlh->nlmsg_type);
+	uint8_t type = NFNL_MSG_TYPE(nlh->nlmsg_type);
+	uint8_t subsys_id = NFNL_SUBSYS_ID(nlh->nlmsg_type);
 	const struct nfnl_subsys_handle *ssh;
 	struct nfnl_callback *cb;
 
@@ -1211,8 +1211,8 @@
 			     int len)
 {
 	struct nfnl_subsys_handle *ssh;
-	u_int8_t type = NFNL_MSG_TYPE(nlh->nlmsg_type);
-	u_int8_t subsys_id = NFNL_SUBSYS_ID(nlh->nlmsg_type);
+	uint8_t type = NFNL_MSG_TYPE(nlh->nlmsg_type);
+	uint8_t subsys_id = NFNL_SUBSYS_ID(nlh->nlmsg_type);
 	int err = 0;
 
 	if (subsys_id > NFNL_MAX_SUBSYS)
@@ -1242,7 +1242,7 @@
 {
 
 	while (len >= NLMSG_SPACE(0)) {
-		u_int32_t rlen;
+		uint32_t rlen;
 		struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
 
 		if (nlh->nlmsg_len < sizeof(struct nlmsghdr)
@@ -1284,8 +1284,8 @@
 static int nfnl_step(struct nfnl_handle *h, struct nlmsghdr *nlh)
 {
 	struct nfnl_subsys_handle *ssh;
-	u_int8_t type = NFNL_MSG_TYPE(nlh->nlmsg_type);
-	u_int8_t subsys_id = NFNL_SUBSYS_ID(nlh->nlmsg_type);
+	uint8_t type = NFNL_MSG_TYPE(nlh->nlmsg_type);
+	uint8_t subsys_id = NFNL_SUBSYS_ID(nlh->nlmsg_type);
 
 	/* Is this an error message? */
 	if (nfnl_is_error(h, nlh)) {
