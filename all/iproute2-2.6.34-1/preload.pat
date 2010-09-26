Only in iproute2-2.6.34: Makefile.orig
diff -ur iproute2-2.6.34-orig/configure iproute2-2.6.34/configure
--- iproute2-2.6.34-orig/configure	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/configure	2010-06-24 09:16:21.649964376 +0200
@@ -86,7 +86,7 @@
 }
 
 EOF
-gcc -I$INCLUDE $IPTC -o /tmp/ipttest /tmp/ipttest.c $IPTL -ldl >/dev/null 2>&1
+gcc -I$INCLUDE $IPTC -o /tmp/ipttest /tmp/ipttest.c $IPTL -ldl
 
 if [ $? -eq 0 ]
 then
Only in iproute2-2.6.34: configure.orig
diff -ur iproute2-2.6.34-orig/include/linux/if_tunnel.h iproute2-2.6.34/include/linux/if_tunnel.h
--- iproute2-2.6.34-orig/include/linux/if_tunnel.h	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/include/linux/if_tunnel.h	2010-06-24 09:16:21.722961259 +0200
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
+#include <linux/ip.h>
 
 #define SIOCGETTUNNEL   (SIOCDEVPRIVATE + 0)
 #define SIOCADDTUNNEL   (SIOCDEVPRIVATE + 1)
Only in iproute2-2.6.34/include/linux: if_tunnel.h.orig
diff -ur iproute2-2.6.34-orig/include/xt-internal.h iproute2-2.6.34/include/xt-internal.h
--- iproute2-2.6.34-orig/include/xt-internal.h	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/include/xt-internal.h	2010-06-24 09:16:21.777960525 +0200
@@ -1,6 +1,8 @@
 #ifndef _XTABLES_INTERNAL_H
 #define _XTABLES_INTERNAL_H 1
 
+#include <sys/types.h>
+
 #ifndef XT_LIB_DIR
 #	define XT_LIB_DIR "/lib/xtables"
 #endif
diff -ur iproute2-2.6.34-orig/ip/ip.c iproute2-2.6.34/ip/ip.c
--- iproute2-2.6.34-orig/ip/ip.c	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/ip/ip.c	2010-06-24 09:16:21.800963882 +0200
@@ -135,11 +135,35 @@
 	return ret;
 }
 
+extern struct link_util *linkutil_list;
+extern struct link_util veth_link_util;
+extern struct link_util gre_link_util;
+extern struct link_util vlan_link_util;
+
+static void preload_linkutil_list(void)
+{                          
+        struct link_util *q;
+        struct link_util **i, *l[4] = {
+                &veth_link_util,
+                &gre_link_util,
+                &vlan_link_util,
+		NULL
+        };
+        //printf("loading actions %p %p\n", l, *l);
+        for(i=l;*i;i++) {  
+                q = *i;    
+                //printf("loaded %s\n", q->id);
+                q->next = linkutil_list;
+                linkutil_list = q;
+        }   
+}                           
 
 int main(int argc, char **argv)
 {
 	char *basename;
 
+	preload_linkutil_list();
+
 	basename = strrchr(argv[0], '/');
 	if (basename == NULL)
 		basename = argv[0];
Only in iproute2-2.6.34/ip: ip.c.orig
diff -ur iproute2-2.6.34-orig/ip/iplink.c iproute2-2.6.34/ip/iplink.c
--- iproute2-2.6.34-orig/ip/iplink.c	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/ip/iplink.c	2010-06-24 09:16:21.822964585 +0200
@@ -92,7 +92,7 @@
 }
 
 static void *BODY;		/* cached dlopen(NULL) handle */
-static struct link_util *linkutil_list;
+struct link_util *linkutil_list;
 
 struct link_util *get_link_kind(const char *id)
 {
Only in iproute2-2.6.34/ip: iplink.c.orig
diff -ur iproute2-2.6.34-orig/misc/Makefile iproute2-2.6.34/misc/Makefile
--- iproute2-2.6.34-orig/misc/Makefile	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/misc/Makefile	2010-06-24 09:16:21.844963697 +0200
@@ -1,7 +1,7 @@
 SSOBJ=ss.o ssfilter.o
 LNSTATOBJ=lnstat.o lnstat_util.o
 
-TARGETS=ss nstat ifstat rtacct arpd lnstat
+TARGETS=ss nstat ifstat rtacct lnstat
 
 include ../Config
 
diff -ur iproute2-2.6.34-orig/tc/m_action.c iproute2-2.6.34/tc/m_action.c
--- iproute2-2.6.34-orig/tc/m_action.c	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/tc/m_action.c	2010-06-24 09:16:21.866962951 +0200
@@ -62,6 +62,37 @@
 	exit(-1);
 }
 
+extern struct action_util gact_action_util;
+extern struct action_util ipt_action_util;
+extern struct action_util mirred_action_util;
+extern struct action_util nat_action_util;
+extern struct action_util pedit_action_util;
+extern struct action_util police_action_util;
+extern struct action_util skbedit_action_util;
+
+static void preload_action_list()
+{
+	struct action_util *q;
+	struct action_util **i, *l[8] = {
+		&gact_action_util,
+		&ipt_action_util,
+		&mirred_action_util,
+		&nat_action_util,
+		&pedit_action_util,
+		&police_action_util,
+		&skbedit_action_util,
+		NULL
+	};
+	//printf("loading actions %p %p\n", l, *l);
+	for(i=l;*i;i++) {
+		q = *i;
+		//printf("loaded %s\n", q->id);
+		q->next = action_list;
+		action_list = q;
+	}
+
+}
+
 static int print_noaopt(struct action_util *au, FILE *f, struct rtattr *opt)
 {
 	if (opt && RTA_PAYLOAD(opt))
@@ -93,6 +124,7 @@
 	int looked4gact = 0;
 restart_s:
 #endif
+	if(!action_list) preload_action_list();
 	for (a = action_list; a; a = a->next) {
 		if (strcmp(a->id, str) == 0)
 			return a;
diff -ur iproute2-2.6.34-orig/tc/m_ematch.c iproute2-2.6.34/tc/m_ematch.c
--- iproute2-2.6.34-orig/tc/m_ematch.c	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/tc/m_ematch.c	2010-06-24 09:16:21.888962401 +0200
@@ -126,6 +126,30 @@
 	return err;
 }
 
+extern struct ematch_util cmp_ematch_util;
+extern struct ematch_util meta_ematch_util;
+extern struct ematch_util nbyte_ematch_util;
+extern struct ematch_util u32_ematch_util;
+
+static void preload_ematch_list()
+{
+	struct ematch_util *q;
+	struct ematch_util **i, *l[5] = {
+		&cmp_ematch_util,
+		&meta_ematch_util,
+		&nbyte_ematch_util,
+		&u32_ematch_util,
+		NULL
+	};
+	//printf("loading actions %p %p\n", l, *l);
+	for(i=l;*i;i++) {
+		q = *i;
+		//printf("loaded %s\n", q->id);
+		q->next = ematch_list;
+		ematch_list = q;
+	}
+}
+
 static struct ematch_util *get_ematch_kind(char *kind)
 {
 	static void *body;
@@ -133,6 +157,8 @@
 	char buf[256];
 	struct ematch_util *e;
 
+	if(!ematch_list) preload_ematch_list();
+
 	for (e = ematch_list; e; e = e->next) {
 		if (strcmp(e->kind, kind) == 0)
 			return e;
diff -ur iproute2-2.6.34-orig/tc/m_pedit.c iproute2-2.6.34/tc/m_pedit.c
--- iproute2-2.6.34-orig/tc/m_pedit.c	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/tc/m_pedit.c	2010-06-24 09:16:21.943962425 +0200
@@ -73,6 +73,33 @@
 
 }
 
+extern struct m_pedit_util p_pedit_icmp;
+extern struct m_pedit_util p_pedit_ip;
+extern struct m_pedit_util p_pedit_ip6;
+extern struct m_pedit_util p_pedit_tcp;
+extern struct m_pedit_util p_pedit_udp;
+
+static void preload_pedit_list()
+{
+	struct m_pedit_util *q;
+	struct m_pedit_util **i, *l[6] = {
+		&p_pedit_icmp,
+		&p_pedit_ip,
+		&p_pedit_ip6,
+		&p_pedit_tcp,
+		&p_pedit_udp,
+		NULL
+	};
+	//printf("loading actions %p %p\n", l, *l);
+	for(i=l;*i;i++) {
+		q = *i;
+		//printf("loaded %s\n", q->id);
+		q->next = pedit_list;
+		pedit_list = q;
+	}
+}
+
+
 struct m_pedit_util
 *get_pedit_kind(char *str)
 {
@@ -81,6 +108,8 @@
 	char buf[256];
 	struct  m_pedit_util *p;
 
+	if(!pedit_list) preload_pedit_list();
+
 	for (p = pedit_list; p; p = p->next) {
 		if (strcmp(p->id, str) == 0)
 			return p;
diff -ur iproute2-2.6.34-orig/tc/tc.c iproute2-2.6.34/tc/tc.c
--- iproute2-2.6.34-orig/tc/tc.c	2010-05-19 17:32:43.000000000 +0200
+++ iproute2-2.6.34/tc/tc.c	2010-06-24 09:16:21.965975110 +0200
@@ -258,6 +258,87 @@
 	return ret;
 }
 
+extern struct qdisc_util cbq_qdisc_util;
+extern struct qdisc_util dsmark_qdisc_util;
+extern struct qdisc_util bfifo_qdisc_util;
+extern struct qdisc_util pfifo_qdisc_util;
+extern struct qdisc_util pfifo_fast_qdisc_util;
+extern struct qdisc_util gred_qdisc_util;
+extern struct qdisc_util hfsc_qdisc_util;
+extern struct qdisc_util htb_qdisc_util;
+extern struct qdisc_util htb2_qdisc_util;
+extern struct qdisc_util ingress_qdisc_util;
+extern struct qdisc_util multiq_qdisc_util;
+extern struct qdisc_util netem_qdisc_util;
+extern struct qdisc_util prio_qdisc_util;
+extern struct qdisc_util red_qdisc_util;
+extern struct qdisc_util rr_qdisc_util;
+extern struct qdisc_util sfq_qdisc_util;
+extern struct qdisc_util tbf_qdisc_util;
+
+static void preload_qdisc_list(void)
+{
+	struct qdisc_util *q;
+	struct qdisc_util **i, *l[18] = {
+		&cbq_qdisc_util,
+		&dsmark_qdisc_util,
+		&bfifo_qdisc_util,
+		&pfifo_qdisc_util,
+		&pfifo_fast_qdisc_util,
+		&gred_qdisc_util,
+		&hfsc_qdisc_util,
+		&htb_qdisc_util,
+		&htb2_qdisc_util,
+		&ingress_qdisc_util,
+		&multiq_qdisc_util,
+		&netem_qdisc_util,
+		&prio_qdisc_util,
+		&red_qdisc_util,
+		&rr_qdisc_util,
+		&sfq_qdisc_util,
+		&tbf_qdisc_util,
+		NULL
+	};
+	//printf("loading qdiscs %p %p\n", l, *l);
+	for(i=l;*i;i++) {
+		q = *i;
+		//printf("loaded %s\n", q->id);
+		q->next = qdisc_list;
+		qdisc_list = q;
+	}
+}
+
+extern struct filter_util basic_filter_util;
+extern struct filter_util flow_filter_util;
+extern struct filter_util fw_filter_util;
+extern struct filter_util route_filter_util;
+extern struct filter_util rsvp_filter_util;
+extern struct filter_util rsvp6_filter_util;
+extern struct filter_util tcindex_filter_util;
+extern struct filter_util u32_filter_util;
+
+static void preload_filter_list(void)
+{
+	struct filter_util *q;
+	struct filter_util **i, *l[9] = {
+		&basic_filter_util,
+		&flow_filter_util,
+		&fw_filter_util,
+		&route_filter_util,
+		&rsvp_filter_util,
+		&rsvp6_filter_util,
+		&tcindex_filter_util,
+		&u32_filter_util,
+		NULL
+	};
+	//printf("loading qdiscs %p %p\n", l, *l);
+	for(i=l;*i;i++) {
+		q = *i;
+		//printf("loaded %s\n", q->id);
+		q->next = filter_list;
+		filter_list = q;
+	}
+}
 
 int main(int argc, char **argv)
 {
@@ -265,6 +346,9 @@
 	int do_batching = 0;
 	char *batchfile = NULL;
 
+	preload_qdisc_list();
+	preload_filter_list();
+
 	while (argc > 1) {
 		if (argv[1][0] != '-')
 			break;
