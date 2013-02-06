--- iproute2-3.6.0-orig/genl/Makefile	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/genl/Makefile	Wed Feb  6 09:20:56 2013
@@ -13,7 +13,7 @@
 GENLLIB :=
 
 ifeq ($(SHARED_LIBS),y)
-LDFLAGS += -Wl,-export-dynamic
+LDFLAGS += 
 LDLIBS  += -lm -ldl
 endif
 
--- iproute2-3.6.0-orig/include/linux/if_tunnel.h	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/include/linux/if_tunnel.h	Wed Feb  6 09:20:56 2013
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
+#include <linux/ip.h>
 
 #define SIOCGETTUNNEL   (SIOCDEVPRIVATE + 0)
 #define SIOCADDTUNNEL   (SIOCDEVPRIVATE + 1)
--- iproute2-3.6.0-orig/include/xt-internal.h	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/include/xt-internal.h	Wed Feb  6 09:20:56 2013
@@ -1,6 +1,8 @@
 #ifndef _XTABLES_INTERNAL_H
 #define _XTABLES_INTERNAL_H 1
 
+#include <sys/types.h>
+
 #ifndef XT_LIB_DIR
 #	define XT_LIB_DIR "/lib/xtables"
 #endif
--- iproute2-3.6.0-orig/ip/Makefile	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/ip/Makefile	Wed Feb  6 09:20:56 2013
@@ -35,7 +35,7 @@
 ifeq ($(SHARED_LIBS),y)
 
 LDLIBS += -ldl
-LDFLAGS += -Wl,-export-dynamic
+LDFLAGS += 
 
 else
 
--- iproute2-3.6.0-orig/ip/ip.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/ip/ip.c	Wed Feb  6 09:20:56 2013
@@ -143,10 +143,42 @@
 	return ret;
 }
 
+extern struct link_util *linkutil_list;
+extern struct link_util veth_link_util;
+extern struct link_util gre_link_util;
+extern struct link_util vlan_link_util;
+extern struct link_util can_link_util;
+extern struct link_util macvtap_link_util;
+extern struct link_util gretap_link_util;
+extern struct link_util vti_link_util;
 
+static void preload_linkutil_list(void)
+{                          
+        struct link_util *q;
+        struct link_util **i, *l[8] = {
+                &veth_link_util,
+                &gre_link_util,
+                &vlan_link_util,
+                &can_link_util,	
+                &macvtap_link_util,	
+                &gretap_link_util,	
+                &vti_link_util,	
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
+
 int main(int argc, char **argv)
 {
 	char *basename;
+
+	preload_linkutil_list();
 
 	basename = strrchr(argv[0], '/');
 	if (basename == NULL)
--- iproute2-3.6.0-orig/ip/iplink.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/ip/iplink.c	Wed Feb  6 09:20:56 2013
@@ -100,7 +100,7 @@
 }
 
 static void *BODY;		/* cached dlopen(NULL) handle */
-static struct link_util *linkutil_list;
+struct link_util *linkutil_list;
 
 struct link_util *get_link_kind(const char *id)
 {
--- iproute2-3.6.0-orig/ip/ipnetns.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/ip/ipnetns.c	Wed Feb  6 09:20:56 2013
@@ -14,6 +14,10 @@
 #include <errno.h>
 #include <unistd.h>
 
+#include <syscall.h>
+#define unshare(flags) ((long)syscall(SYS_unshare, flags))
+
+
 #include "utils.h"
 #include "ip_common.h"
 
--- iproute2-3.6.0-orig/misc/Makefile	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/misc/Makefile	Wed Feb  6 09:20:56 2013
@@ -1,7 +1,7 @@
 SSOBJ=ss.o ssfilter.o
 LNSTATOBJ=lnstat.o lnstat_util.o
 
-TARGETS=ss nstat ifstat rtacct arpd lnstat
+TARGETS=ss nstat ifstat rtacct lnstat
 
 include ../Config
 
--- iproute2-3.6.0-orig/tc/Makefile	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/tc/Makefile	Wed Feb  6 09:20:56 2013
@@ -50,6 +50,8 @@
 TCMODULES += q_mqprio.o
 TCMODULES += q_codel.o
 TCMODULES += q_fq_codel.o
+TCMODULES += m_ipt.o
+TCMODULES += m_xt.o
 
 ifeq ($(TC_CONFIG_IPSET), y)
   TCMODULES += em_ipset.o
@@ -76,11 +78,11 @@
 endif
 
 TCOBJ += $(TCMODULES)
-LDLIBS += -L. -ltc -lm
+LDLIBS += -L. -ltc -lm -lxtables
 
 ifeq ($(SHARED_LIBS),y)
 LDLIBS += -ldl
-LDFLAGS += -Wl,-export-dynamic
+LDFLAGS += 
 endif
 
 TCLIB := tc_core.o
--- iproute2-3.6.0-orig/tc/m_action.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/tc/m_action.c	Wed Feb  6 09:20:56 2013
@@ -62,6 +62,41 @@
 	exit(-1);
 }
 
+extern struct action_util gact_action_util;
+extern struct action_util ipt_action_util;
+extern struct action_util mirred_action_util;
+extern struct action_util nat_action_util;
+extern struct action_util pedit_action_util;
+extern struct action_util police_action_util;
+extern struct action_util skbedit_action_util;
+extern struct action_util csum_action_util;
+extern struct action_util xt_action_util;
+
+static void preload_action_list()
+{
+	struct action_util *q;
+	struct action_util **i, *l[10] = {
+		&gact_action_util,
+		&ipt_action_util,
+		&mirred_action_util,
+		&nat_action_util,
+		&pedit_action_util,
+		&police_action_util,
+		&skbedit_action_util,
+		&csum_action_util,
+		&xt_action_util,
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
@@ -93,6 +128,7 @@
 	int looked4gact = 0;
 restart_s:
 #endif
+	if(!action_list) preload_action_list();
 	for (a = action_list; a; a = a->next) {
 		if (strcmp(a->id, str) == 0)
 			return a;
--- iproute2-3.6.0-orig/tc/m_ematch.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/tc/m_ematch.c	Wed Feb  6 09:20:56 2013
@@ -126,12 +126,42 @@
 	return err;
 }
 
+extern struct ematch_util cmp_ematch_util;
+extern struct ematch_util meta_ematch_util;
+extern struct ematch_util nbyte_ematch_util;
+extern struct ematch_util u32_ematch_util;
+extern struct ematch_util canid_ematch_util;
+extern struct ematch_util ipset_ematch_util;
+
+static void preload_ematch_list()
+{
+	struct ematch_util *q;
+	struct ematch_util **i, *l[7] = {
+		&cmp_ematch_util,
+		&meta_ematch_util,
+		&nbyte_ematch_util,
+		&u32_ematch_util,
+		&canid_ematch_util,
+		&ipset_ematch_util,
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
 	void *dlh;
 	char buf[256];
 	struct ematch_util *e;
+
+	if(!ematch_list) preload_ematch_list();
 
 	for (e = ematch_list; e; e = e->next) {
 		if (strcmp(e->kind, kind) == 0)
--- iproute2-3.6.0-orig/tc/m_ipt.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/tc/m_ipt.c	Wed Feb  6 09:20:56 2013
@@ -68,7 +68,7 @@
 
 }
 
-void
+static void
 xtables_register_target(struct iptables_target *me)
 {
 	me->next = t_list;
@@ -357,7 +357,7 @@
 /*
  * we may need to check for version mismatch
 */
-int
+static int
 build_st(struct iptables_target *target, struct ipt_entry_target *t)
 {
 	unsigned int nfcache = 0;
--- iproute2-3.6.0-orig/tc/m_pedit.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/tc/m_pedit.c	Wed Feb  6 09:20:56 2013
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
@@ -80,6 +107,8 @@
 	void *dlh;
 	char buf[256];
 	struct  m_pedit_util *p;
+
+	if(!pedit_list) preload_pedit_list();
 
 	for (p = pedit_list; p; p = p->next) {
 		if (strcmp(p->id, str) == 0)
--- iproute2-3.6.0-orig/tc/m_xt.c	Mon Oct  1 15:39:21 2012
+++ iproute2-3.6.0/tc/m_xt.c	Wed Feb  6 09:20:56 2013
@@ -43,6 +43,9 @@
 #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
 #endif
 
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+
 static const char *tname = "mangle";
 
 char *lib_dir;
