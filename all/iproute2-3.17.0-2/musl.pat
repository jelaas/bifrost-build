Only in iproute2-3.17.0-patched: Config
--- iproute2-3.17.0/Makefile	Sun Oct 12 17:19:22 2014
+++ iproute2-3.17.0-patched/Makefile	Sun Oct 12 17:39:07 2014
@@ -11,7 +11,7 @@
 # Path to db_185.h include
 DBM_INCLUDE:=$(ROOTDIR)/usr/include
 
-SHARED_LIBS = y
+SHARED_LIBS = n
 
 DEFINES= -DRESOLVE_HOSTNAMES -DLIBDIR=\"$(LIBDIR)\"
 ifneq ($(SHARED_LIBS),y)
Only in iproute2-3.17.0-patched: Makefile~
Only in iproute2-3.17.0-patched: bridge/bridge
Only in iproute2-3.17.0-patched: bridge/bridge.o
Only in iproute2-3.17.0-patched: bridge/fdb.o
Only in iproute2-3.17.0-patched: bridge/link.o
Only in iproute2-3.17.0-patched: bridge/mdb.o
Only in iproute2-3.17.0-patched: bridge/monitor.o
Only in iproute2-3.17.0-patched: bridge/vlan.o
--- iproute2-3.17.0/configure	Sun Oct 12 17:19:22 2014
+++ iproute2-3.17.0-patched/configure	Sun Oct 12 17:36:56 2014
@@ -166,9 +166,9 @@
 		return
 	fi
 
-	for dir in /lib /usr/lib /usr/local/lib
+	for dir in /opt/musl/lib
 	do
-		for file in $dir/{xtables,iptables}/lib*t_*so ; do
+		for file in $dir/{xtables,iptables}/lib*t_*a ; do
 			if [ -f $file ]; then
 				echo ${file%/*}
 				echo "IPT_LIB_DIR:=${file%/*}" >> Config
Only in iproute2-3.17.0-patched: configure~
Only in iproute2-3.17.0-patched: genl/ctrl.o
Only in iproute2-3.17.0-patched: genl/genl
Only in iproute2-3.17.0-patched: genl/genl.o
Only in iproute2-3.17.0-patched: genl/static-syms.h
Only in iproute2-3.17.0-patched: genl/static-syms.o
Only in iproute2-3.17.0-patched: ip/ip
Only in iproute2-3.17.0-patched: ip/ip.o
Only in iproute2-3.17.0-patched: ip/ip6tunnel.o
Only in iproute2-3.17.0-patched: ip/ipaddress.o
Only in iproute2-3.17.0-patched: ip/ipaddrlabel.o
Only in iproute2-3.17.0-patched: ip/ipl2tp.o
Only in iproute2-3.17.0-patched: ip/iplink.o
Only in iproute2-3.17.0-patched: ip/iplink_bond.o
Only in iproute2-3.17.0-patched: ip/iplink_bond_slave.o
Only in iproute2-3.17.0-patched: ip/iplink_can.o
Only in iproute2-3.17.0-patched: ip/iplink_hsr.o
Only in iproute2-3.17.0-patched: ip/iplink_ipoib.o
Only in iproute2-3.17.0-patched: ip/iplink_macvlan.o
Only in iproute2-3.17.0-patched: ip/iplink_macvtap.o
Only in iproute2-3.17.0-patched: ip/iplink_vlan.o
Only in iproute2-3.17.0-patched: ip/iplink_vxlan.o
Only in iproute2-3.17.0-patched: ip/ipmaddr.o
Only in iproute2-3.17.0-patched: ip/ipmonitor.o
Only in iproute2-3.17.0-patched: ip/ipmroute.o
Only in iproute2-3.17.0-patched: ip/ipneigh.o
Only in iproute2-3.17.0-patched: ip/ipnetconf.o
Only in iproute2-3.17.0-patched: ip/ipnetns.o
Only in iproute2-3.17.0-patched: ip/ipntable.o
Only in iproute2-3.17.0-patched: ip/ipprefix.o
Only in iproute2-3.17.0-patched: ip/iproute.o
Only in iproute2-3.17.0-patched: ip/iprule.o
Only in iproute2-3.17.0-patched: ip/iptoken.o
Only in iproute2-3.17.0-patched: ip/iptunnel.o
Only in iproute2-3.17.0-patched: ip/iptuntap.o
Only in iproute2-3.17.0-patched: ip/ipxfrm.o
Only in iproute2-3.17.0-patched: ip/link_gre.o
Only in iproute2-3.17.0-patched: ip/link_gre6.o
Only in iproute2-3.17.0-patched: ip/link_ip6tnl.o
Only in iproute2-3.17.0-patched: ip/link_iptnl.o
Only in iproute2-3.17.0-patched: ip/link_veth.o
Only in iproute2-3.17.0-patched: ip/link_vti.o
Only in iproute2-3.17.0-patched: ip/link_vti6.o
Only in iproute2-3.17.0-patched: ip/rtm_map.o
Only in iproute2-3.17.0-patched: ip/rtmon
Only in iproute2-3.17.0-patched: ip/rtmon.o
Only in iproute2-3.17.0-patched: ip/static-syms.h
Only in iproute2-3.17.0-patched: ip/static-syms.o
Only in iproute2-3.17.0-patched: ip/tcp_metrics.o
Only in iproute2-3.17.0-patched: ip/tunnel.o
Only in iproute2-3.17.0-patched: ip/xfrm_monitor.o
Only in iproute2-3.17.0-patched: ip/xfrm_policy.o
Only in iproute2-3.17.0-patched: ip/xfrm_state.o
Only in iproute2-3.17.0-patched: lib/dnet_ntop.o
Only in iproute2-3.17.0-patched: lib/dnet_pton.o
Only in iproute2-3.17.0-patched: lib/inet_proto.o
Only in iproute2-3.17.0-patched: lib/ipx_ntop.o
Only in iproute2-3.17.0-patched: lib/ipx_pton.o
Only in iproute2-3.17.0-patched: lib/libgenl.o
Only in iproute2-3.17.0-patched: lib/libnetlink.a
Only in iproute2-3.17.0-patched: lib/libnetlink.o
Only in iproute2-3.17.0-patched: lib/libutil.a
Only in iproute2-3.17.0-patched: lib/ll_addr.o
Only in iproute2-3.17.0-patched: lib/ll_map.o
Only in iproute2-3.17.0-patched: lib/ll_proto.o
Only in iproute2-3.17.0-patched: lib/ll_types.o
Only in iproute2-3.17.0-patched: lib/rt_names.o
Only in iproute2-3.17.0-patched: lib/utils.o
Only in iproute2-3.17.0-patched: man/man8/ip-address.8
Only in iproute2-3.17.0-patched: man/man8/ip-link.8
Only in iproute2-3.17.0-patched: man/man8/ip-route.8
--- iproute2-3.17.0/misc/Makefile	Sun Oct 12 17:19:22 2014
+++ iproute2-3.17.0-patched/misc/Makefile	Sun Oct 12 17:55:16 2014
@@ -1,7 +1,7 @@
 SSOBJ=ss.o ssfilter.o
 LNSTATOBJ=lnstat.o lnstat_util.o
 
-TARGETS=ss nstat ifstat rtacct arpd lnstat
+TARGETS=ss nstat ifstat rtacct lnstat
 
 include ../Config
 
Only in iproute2-3.17.0-patched: misc/Makefile~
Only in iproute2-3.17.0-patched: misc/ifstat
Only in iproute2-3.17.0-patched: misc/lnstat
Only in iproute2-3.17.0-patched: misc/lnstat.o
Only in iproute2-3.17.0-patched: misc/lnstat_util.o
Only in iproute2-3.17.0-patched: misc/nstat
Only in iproute2-3.17.0-patched: misc/rtacct
Only in iproute2-3.17.0-patched: misc/ss
Only in iproute2-3.17.0-patched: misc/ss.o
Only in iproute2-3.17.0-patched: misc/ssfilter.c
Only in iproute2-3.17.0-patched: misc/ssfilter.o
Only in iproute2-3.17.0-patched: netem/experimental.dist
Only in iproute2-3.17.0-patched: netem/maketable
Only in iproute2-3.17.0-patched: netem/normal
Only in iproute2-3.17.0-patched: netem/normal.dist
Only in iproute2-3.17.0-patched: netem/pareto
Only in iproute2-3.17.0-patched: netem/pareto.dist
Only in iproute2-3.17.0-patched: netem/paretonormal
Only in iproute2-3.17.0-patched: netem/paretonormal.dist
--- iproute2-3.17.0/tc/Makefile	Sun Oct 12 17:19:22 2014
+++ iproute2-3.17.0-patched/tc/Makefile	Sun Oct 12 17:52:49 2014
@@ -111,7 +111,7 @@
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -fpic $< -o $@
 
 
-all: libtc.a tc $(TCSO)
+all: libtc.a tc
 
 tc: $(TCOBJ) $(TCLIB)
 
Only in iproute2-3.17.0-patched: tc/Makefile~
Only in iproute2-3.17.0-patched: tc/em_canid.o
Only in iproute2-3.17.0-patched: tc/em_cmp.o
Only in iproute2-3.17.0-patched: tc/em_ipset.o
Only in iproute2-3.17.0-patched: tc/em_meta.o
Only in iproute2-3.17.0-patched: tc/em_nbyte.o
Only in iproute2-3.17.0-patched: tc/em_u32.o
Only in iproute2-3.17.0-patched: tc/emp_ematch.lex.o
Only in iproute2-3.17.0-patched: tc/emp_ematch.yacc.c
Only in iproute2-3.17.0-patched: tc/emp_ematch.yacc.h
Only in iproute2-3.17.0-patched: tc/emp_ematch.yacc.o
Only in iproute2-3.17.0-patched: tc/emp_ematch.yacc.output
Only in iproute2-3.17.0-patched: tc/f_basic.o
Only in iproute2-3.17.0-patched: tc/f_bpf.o
Only in iproute2-3.17.0-patched: tc/f_cgroup.o
Only in iproute2-3.17.0-patched: tc/f_flow.o
Only in iproute2-3.17.0-patched: tc/f_fw.o
Only in iproute2-3.17.0-patched: tc/f_route.o
Only in iproute2-3.17.0-patched: tc/f_rsvp.o
Only in iproute2-3.17.0-patched: tc/f_tcindex.o
Only in iproute2-3.17.0-patched: tc/f_u32.o
Only in iproute2-3.17.0-patched: tc/libtc.a
Only in iproute2-3.17.0-patched: tc/m_action.o
Only in iproute2-3.17.0-patched: tc/m_csum.o
Only in iproute2-3.17.0-patched: tc/m_ematch.o
Only in iproute2-3.17.0-patched: tc/m_estimator.o
Only in iproute2-3.17.0-patched: tc/m_gact.o
Only in iproute2-3.17.0-patched: tc/m_mirred.o
Only in iproute2-3.17.0-patched: tc/m_nat.o
Only in iproute2-3.17.0-patched: tc/m_pedit.o
Only in iproute2-3.17.0-patched: tc/m_police.o
Only in iproute2-3.17.0-patched: tc/m_simple.o
Only in iproute2-3.17.0-patched: tc/m_skbedit.o
Only in iproute2-3.17.0-patched: tc/p_icmp.o
Only in iproute2-3.17.0-patched: tc/p_ip.o
Only in iproute2-3.17.0-patched: tc/p_tcp.o
Only in iproute2-3.17.0-patched: tc/p_udp.o
Only in iproute2-3.17.0-patched: tc/q_cbq.o
Only in iproute2-3.17.0-patched: tc/q_choke.o
Only in iproute2-3.17.0-patched: tc/q_codel.o
Only in iproute2-3.17.0-patched: tc/q_drr.o
Only in iproute2-3.17.0-patched: tc/q_dsmark.o
Only in iproute2-3.17.0-patched: tc/q_fifo.o
Only in iproute2-3.17.0-patched: tc/q_fq.o
Only in iproute2-3.17.0-patched: tc/q_fq_codel.o
Only in iproute2-3.17.0-patched: tc/q_gred.o
Only in iproute2-3.17.0-patched: tc/q_hfsc.o
Only in iproute2-3.17.0-patched: tc/q_hhf.o
Only in iproute2-3.17.0-patched: tc/q_htb.o
Only in iproute2-3.17.0-patched: tc/q_ingress.o
Only in iproute2-3.17.0-patched: tc/q_mqprio.o
Only in iproute2-3.17.0-patched: tc/q_multiq.o
Only in iproute2-3.17.0-patched: tc/q_netem.o
Only in iproute2-3.17.0-patched: tc/q_pie.o
Only in iproute2-3.17.0-patched: tc/q_prio.o
Only in iproute2-3.17.0-patched: tc/q_qfq.o
Only in iproute2-3.17.0-patched: tc/q_red.o
Only in iproute2-3.17.0-patched: tc/q_rr.o
Only in iproute2-3.17.0-patched: tc/q_sfb.o
Only in iproute2-3.17.0-patched: tc/q_sfq.o
Only in iproute2-3.17.0-patched: tc/q_tbf.o
Only in iproute2-3.17.0-patched: tc/static-syms.h
Only in iproute2-3.17.0-patched: tc/static-syms.o
Only in iproute2-3.17.0-patched: tc/tc
Only in iproute2-3.17.0-patched: tc/tc.o
Only in iproute2-3.17.0-patched: tc/tc_cbq.o
Only in iproute2-3.17.0-patched: tc/tc_class.o
Only in iproute2-3.17.0-patched: tc/tc_core.o
Only in iproute2-3.17.0-patched: tc/tc_estimator.o
Only in iproute2-3.17.0-patched: tc/tc_filter.o
Only in iproute2-3.17.0-patched: tc/tc_monitor.o
Only in iproute2-3.17.0-patched: tc/tc_qdisc.o
Only in iproute2-3.17.0-patched: tc/tc_red.o
Only in iproute2-3.17.0-patched: tc/tc_stab.o
Only in iproute2-3.17.0-patched: tc/tc_util.o
