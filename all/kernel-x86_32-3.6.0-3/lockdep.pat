commit b3c581d5d7130fc7f2eab9ab14c8de8882b42380
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Oct 3 23:18:39 2012 +0000

    team: set qdisc_tx_busylock to avoid LOCKDEP splat
    
    If a qdisc is installed on a team device, its possible to get
    a lockdep splat under stress, because nested dev_queue_xmit() can
    lock busylock a second time (on a different device, so its a false
    positive)
    
    Avoid this problem using a distinct lock_class_key for team
    devices.
    
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Jiri Pirko <jpirko@redhat.com>
    Acked-by: Jiri Pirko <jiri@resnulli.us>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 5c7547c..d44cca3 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1315,6 +1315,7 @@ static const struct team_option team_options[] = {
 
 static struct lock_class_key team_netdev_xmit_lock_key;
 static struct lock_class_key team_netdev_addr_lock_key;
+static struct lock_class_key team_tx_busylock_key;
 
 static void team_set_lockdep_class_one(struct net_device *dev,
 				       struct netdev_queue *txq,
@@ -1327,6 +1328,7 @@ static void team_set_lockdep_class(struct net_device *dev)
 {
 	lockdep_set_class(&dev->addr_list_lock, &team_netdev_addr_lock_key);
 	netdev_for_each_tx_queue(dev, team_set_lockdep_class_one, NULL);
+	dev->qdisc_tx_busylock = &team_tx_busylock_key;
 }
 
 static int team_init(struct net_device *dev)
commit 49ee49202b4ac4be95d05e4bf24a9ac8b54c5528
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Oct 3 23:05:26 2012 +0000

    bonding: set qdisc_tx_busylock to avoid LOCKDEP splat
    
    If a qdisc is installed on a bonding device, its possible to get
    following lockdep splat under stress :
    
     =============================================
     [ INFO: possible recursive locking detected ]
     3.6.0+ #211 Not tainted
     ---------------------------------------------
     ping/4876 is trying to acquire lock:
      (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+.-...}, at: [<ffffffff8157a191>] dev_queue_xmit+0xe1/0x830
    
     but task is already holding lock:
      (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+.-...}, at: [<ffffffff8157a191>] dev_queue_xmit+0xe1/0x830
    
     other info that might help us debug this:
      Possible unsafe locking scenario:
    
            CPU0
            ----
       lock(dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
       lock(dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
    
      *** DEADLOCK ***
    
      May be due to missing lock nesting notation
    
     6 locks held by ping/4876:
      #0:  (sk_lock-AF_INET){+.+.+.}, at: [<ffffffff815e5030>] raw_sendmsg+0x600/0xc30
      #1:  (rcu_read_lock_bh){.+....}, at: [<ffffffff815ba4bd>] ip_finish_output+0x12d/0x870
      #2:  (rcu_read_lock_bh){.+....}, at: [<ffffffff8157a0b0>] dev_queue_xmit+0x0/0x830
      #3:  (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+.-...}, at: [<ffffffff8157a191>] dev_queue_xmit+0xe1/0x830
      #4:  (&bond->lock){++.?..}, at: [<ffffffffa02128c1>] bond_start_xmit+0x31/0x4b0 [bonding]
      #5:  (rcu_read_lock_bh){.+....}, at: [<ffffffff8157a0b0>] dev_queue_xmit+0x0/0x830
    
     stack backtrace:
     Pid: 4876, comm: ping Not tainted 3.6.0+ #211
     Call Trace:
      [<ffffffff810a0145>] __lock_acquire+0x715/0x1b80
      [<ffffffff810a256b>] ? mark_held_locks+0x9b/0x100
      [<ffffffff810a1bf2>] lock_acquire+0x92/0x1d0
      [<ffffffff8157a191>] ? dev_queue_xmit+0xe1/0x830
      [<ffffffff81726b7c>] _raw_spin_lock+0x3c/0x50
      [<ffffffff8157a191>] ? dev_queue_xmit+0xe1/0x830
      [<ffffffff8106264d>] ? rcu_read_lock_bh_held+0x5d/0x90
      [<ffffffff8157a191>] dev_queue_xmit+0xe1/0x830
      [<ffffffff8157a0b0>] ? netdev_pick_tx+0x570/0x570
      [<ffffffffa0212a6a>] bond_start_xmit+0x1da/0x4b0 [bonding]
      [<ffffffff815796d0>] dev_hard_start_xmit+0x240/0x6b0
      [<ffffffff81597c6e>] sch_direct_xmit+0xfe/0x2a0
      [<ffffffff8157a249>] dev_queue_xmit+0x199/0x830
      [<ffffffff8157a0b0>] ? netdev_pick_tx+0x570/0x570
      [<ffffffff815ba96f>] ip_finish_output+0x5df/0x870
      [<ffffffff815ba4bd>] ? ip_finish_output+0x12d/0x870
      [<ffffffff815bb964>] ip_output+0x54/0xf0
      [<ffffffff815bad48>] ip_local_out+0x28/0x90
      [<ffffffff815bc444>] ip_send_skb+0x14/0x50
      [<ffffffff815bc4b2>] ip_push_pending_frames+0x32/0x40
      [<ffffffff815e536a>] raw_sendmsg+0x93a/0xc30
      [<ffffffff8128d570>] ? selinux_file_send_sigiotask+0x1f0/0x1f0
      [<ffffffff8109ddb4>] ? __lock_is_held+0x54/0x80
      [<ffffffff815f6730>] ? inet_recvmsg+0x220/0x220
      [<ffffffff8109ddb4>] ? __lock_is_held+0x54/0x80
      [<ffffffff815f6855>] inet_sendmsg+0x125/0x240
      [<ffffffff815f6730>] ? inet_recvmsg+0x220/0x220
      [<ffffffff8155cddb>] sock_sendmsg+0xab/0xe0
      [<ffffffff810a1650>] ? lock_release_non_nested+0xa0/0x2e0
      [<ffffffff810a1650>] ? lock_release_non_nested+0xa0/0x2e0
      [<ffffffff8155d18c>] __sys_sendmsg+0x37c/0x390
      [<ffffffff81195b2a>] ? fsnotify+0x2ca/0x7e0
      [<ffffffff811958e8>] ? fsnotify+0x88/0x7e0
      [<ffffffff81361f36>] ? put_ldisc+0x56/0xd0
      [<ffffffff8116f98a>] ? fget_light+0x3da/0x510
      [<ffffffff8155f6c4>] sys_sendmsg+0x44/0x80
      [<ffffffff8172fc22>] system_call_fastpath+0x16/0x1b
    
    Avoid this problem using a distinct lock_class_key for bonding
    devices.
    
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Jay Vosburgh <fubar@us.ibm.com>
    Cc: Andy Gospodarek <andy@greyhouse.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7858c58..b721902 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4826,6 +4826,7 @@ static int bond_check_params(struct bond_params *params)
 
 static struct lock_class_key bonding_netdev_xmit_lock_key;
 static struct lock_class_key bonding_netdev_addr_lock_key;
+static struct lock_class_key bonding_tx_busylock_key;
 
 static void bond_set_lockdep_class_one(struct net_device *dev,
 				       struct netdev_queue *txq,
@@ -4840,6 +4841,7 @@ static void bond_set_lockdep_class(struct net_device *dev)
 	lockdep_set_class(&dev->addr_list_lock,
 			  &bonding_netdev_addr_lock_key);
 	netdev_for_each_tx_queue(dev, bond_set_lockdep_class_one, NULL);
+	dev->qdisc_tx_busylock = &bonding_tx_busylock_key;
 }
 
 /*
commit 23d3b8bfb8eb20e7d96afa09991e6a5ed1c83164
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Sep 5 01:02:56 2012 +0000

    net: qdisc busylock needs lockdep annotations
    
    It seems we need to provide ability for stacked devices
    to use specific lock_class_key for sch->busylock
    
    We could instead default l2tpeth tx_queue_len to 0 (no qdisc), but
    a user might use a qdisc anyway.
    
    (So same fixes are probably needed on non LLTX stacked drivers)
    
    Noticed while stressing L2TPV3 setup :
    
    ======================================================
     [ INFO: possible circular locking dependency detected ]
     3.6.0-rc3+ #788 Not tainted
     -------------------------------------------------------
     netperf/4660 is trying to acquire lock:
      (l2tpsock){+.-...}, at: [<ffffffffa0208db2>] l2tp_xmit_skb+0x172/0xa50 [l2tp_core]
    
     but task is already holding lock:
      (&(&sch->busylock)->rlock){+.-...}, at: [<ffffffff81596595>] dev_queue_xmit+0xd75/0xe00
    
     which lock already depends on the new lock.
    
     the existing dependency chain (in reverse order) is:
    
     -> #1 (&(&sch->busylock)->rlock){+.-...}:
            [<ffffffff810a5df0>] lock_acquire+0x90/0x200
            [<ffffffff817499fc>] _raw_spin_lock_irqsave+0x4c/0x60
            [<ffffffff81074872>] __wake_up+0x32/0x70
            [<ffffffff8136d39e>] tty_wakeup+0x3e/0x80
            [<ffffffff81378fb3>] pty_write+0x73/0x80
            [<ffffffff8136cb4c>] tty_put_char+0x3c/0x40
            [<ffffffff813722b2>] process_echoes+0x142/0x330
            [<ffffffff813742ab>] n_tty_receive_buf+0x8fb/0x1230
            [<ffffffff813777b2>] flush_to_ldisc+0x142/0x1c0
            [<ffffffff81062818>] process_one_work+0x198/0x760
            [<ffffffff81063236>] worker_thread+0x186/0x4b0
            [<ffffffff810694d3>] kthread+0x93/0xa0
            [<ffffffff81753e24>] kernel_thread_helper+0x4/0x10
    
     -> #0 (l2tpsock){+.-...}:
            [<ffffffff810a5288>] __lock_acquire+0x1628/0x1b10
            [<ffffffff810a5df0>] lock_acquire+0x90/0x200
            [<ffffffff817498c1>] _raw_spin_lock+0x41/0x50
            [<ffffffffa0208db2>] l2tp_xmit_skb+0x172/0xa50 [l2tp_core]
            [<ffffffffa021a802>] l2tp_eth_dev_xmit+0x32/0x60 [l2tp_eth]
            [<ffffffff815952b2>] dev_hard_start_xmit+0x502/0xa70
            [<ffffffff815b63ce>] sch_direct_xmit+0xfe/0x290
            [<ffffffff81595a05>] dev_queue_xmit+0x1e5/0xe00
            [<ffffffff815d9d60>] ip_finish_output+0x3d0/0x890
            [<ffffffff815db019>] ip_output+0x59/0xf0
            [<ffffffff815da36d>] ip_local_out+0x2d/0xa0
            [<ffffffff815da5a3>] ip_queue_xmit+0x1c3/0x680
            [<ffffffff815f4192>] tcp_transmit_skb+0x402/0xa60
            [<ffffffff815f4a94>] tcp_write_xmit+0x1f4/0xa30
            [<ffffffff815f5300>] tcp_push_one+0x30/0x40
            [<ffffffff815e6672>] tcp_sendmsg+0xe82/0x1040
            [<ffffffff81614495>] inet_sendmsg+0x125/0x230
            [<ffffffff81576cdc>] sock_sendmsg+0xdc/0xf0
            [<ffffffff81579ece>] sys_sendto+0xfe/0x130
            [<ffffffff81752c92>] system_call_fastpath+0x16/0x1b
      Possible unsafe locking scenario:
    
            CPU0                    CPU1
            ----                    ----
       lock(&(&sch->busylock)->rlock);
                                    lock(l2tpsock);
                                    lock(&(&sch->busylock)->rlock);
       lock(l2tpsock);
    
      *** DEADLOCK ***
    
     5 locks held by netperf/4660:
      #0:  (sk_lock-AF_INET){+.+.+.}, at: [<ffffffff815e581c>] tcp_sendmsg+0x2c/0x1040
      #1:  (rcu_read_lock){.+.+..}, at: [<ffffffff815da3e0>] ip_queue_xmit+0x0/0x680
      #2:  (rcu_read_lock_bh){.+....}, at: [<ffffffff815d9ac5>] ip_finish_output+0x135/0x890
      #3:  (rcu_read_lock_bh){.+....}, at: [<ffffffff81595820>] dev_queue_xmit+0x0/0xe00
      #4:  (&(&sch->busylock)->rlock){+.-...}, at: [<ffffffff81596595>] dev_queue_xmit+0xd75/0xe00
    
     stack backtrace:
     Pid: 4660, comm: netperf Not tainted 3.6.0-rc3+ #788
     Call Trace:
      [<ffffffff8173dbf8>] print_circular_bug+0x1fb/0x20c
      [<ffffffff810a5288>] __lock_acquire+0x1628/0x1b10
      [<ffffffff810a334b>] ? check_usage+0x9b/0x4d0
      [<ffffffff810a3f44>] ? __lock_acquire+0x2e4/0x1b10
      [<ffffffff810a5df0>] lock_acquire+0x90/0x200
      [<ffffffffa0208db2>] ? l2tp_xmit_skb+0x172/0xa50 [l2tp_core]
      [<ffffffff817498c1>] _raw_spin_lock+0x41/0x50
      [<ffffffffa0208db2>] ? l2tp_xmit_skb+0x172/0xa50 [l2tp_core]
      [<ffffffffa0208db2>] l2tp_xmit_skb+0x172/0xa50 [l2tp_core]
      [<ffffffffa021a802>] l2tp_eth_dev_xmit+0x32/0x60 [l2tp_eth]
      [<ffffffff815952b2>] dev_hard_start_xmit+0x502/0xa70
      [<ffffffff81594e0e>] ? dev_hard_start_xmit+0x5e/0xa70
      [<ffffffff81595961>] ? dev_queue_xmit+0x141/0xe00
      [<ffffffff815b63ce>] sch_direct_xmit+0xfe/0x290
      [<ffffffff81595a05>] dev_queue_xmit+0x1e5/0xe00
      [<ffffffff81595820>] ? dev_hard_start_xmit+0xa70/0xa70
      [<ffffffff815d9d60>] ip_finish_output+0x3d0/0x890
      [<ffffffff815d9ac5>] ? ip_finish_output+0x135/0x890
      [<ffffffff815db019>] ip_output+0x59/0xf0
      [<ffffffff815da36d>] ip_local_out+0x2d/0xa0
      [<ffffffff815da5a3>] ip_queue_xmit+0x1c3/0x680
      [<ffffffff815da3e0>] ? ip_local_out+0xa0/0xa0
      [<ffffffff815f4192>] tcp_transmit_skb+0x402/0xa60
      [<ffffffff815fa25e>] ? tcp_md5_do_lookup+0x18e/0x1a0
      [<ffffffff815f4a94>] tcp_write_xmit+0x1f4/0xa30
      [<ffffffff815f5300>] tcp_push_one+0x30/0x40
      [<ffffffff815e6672>] tcp_sendmsg+0xe82/0x1040
      [<ffffffff81614495>] inet_sendmsg+0x125/0x230
      [<ffffffff81614370>] ? inet_create+0x6b0/0x6b0
      [<ffffffff8157e6e2>] ? sock_update_classid+0xc2/0x3b0
      [<ffffffff8157e750>] ? sock_update_classid+0x130/0x3b0
      [<ffffffff81576cdc>] sock_sendmsg+0xdc/0xf0
      [<ffffffff81162579>] ? fget_light+0x3f9/0x4f0
      [<ffffffff81579ece>] sys_sendto+0xfe/0x130
      [<ffffffff810a69ad>] ? trace_hardirqs_on+0xd/0x10
      [<ffffffff8174a0b0>] ? _raw_spin_unlock_irq+0x30/0x50
      [<ffffffff810757e3>] ? finish_task_switch+0x83/0xf0
      [<ffffffff810757a6>] ? finish_task_switch+0x46/0xf0
      [<ffffffff81752cb7>] ? sysret_check+0x1b/0x56
      [<ffffffff81752c92>] system_call_fastpath+0x16/0x1b
    
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ccac82e..ae3153c0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1322,6 +1322,8 @@ struct net_device {
 	/* phy device may attach itself for hardware timestamping */
 	struct phy_device *phydev;
 
+	struct lock_class_key *qdisc_tx_busylock;
+
 	/* group the device belongs to */
 	int group;
 
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index f9ee74d..ba89997 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -67,6 +67,7 @@ static inline struct l2tp_eth_net *l2tp_eth_pernet(struct net *net)
 	return net_generic(net, l2tp_eth_net_id);
 }
 
+static struct lock_class_key l2tp_eth_tx_busylock;
 static int l2tp_eth_dev_init(struct net_device *dev)
 {
 	struct l2tp_eth *priv = netdev_priv(dev);
@@ -74,7 +75,7 @@ static int l2tp_eth_dev_init(struct net_device *dev)
 	priv->dev = dev;
 	eth_hw_addr_random(dev);
 	memset(&dev->broadcast[0], 0xff, 6);
-
+	dev->qdisc_tx_busylock = &l2tp_eth_tx_busylock;
 	return 0;
 }
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6c4d5fe..aefc150 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -527,6 +527,8 @@ struct Qdisc_ops pfifo_fast_ops __read_mostly = {
 };
 EXPORT_SYMBOL(pfifo_fast_ops);
 
+static struct lock_class_key qdisc_tx_busylock;
+
 struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 			  struct Qdisc_ops *ops)
 {
@@ -534,6 +536,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	struct Qdisc *sch;
 	unsigned int size = QDISC_ALIGN(sizeof(*sch)) + ops->priv_size;
 	int err = -ENOBUFS;
+	struct net_device *dev = dev_queue->dev;
 
 	p = kzalloc_node(size, GFP_KERNEL,
 			 netdev_queue_numa_node_read(dev_queue));
@@ -553,12 +556,16 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	}
 	INIT_LIST_HEAD(&sch->list);
 	skb_queue_head_init(&sch->q);
+
 	spin_lock_init(&sch->busylock);
+	lockdep_set_class(&sch->busylock,
+			  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
+
 	sch->ops = ops;
 	sch->enqueue = ops->enqueue;
 	sch->dequeue = ops->dequeue;
 	sch->dev_queue = dev_queue;
-	dev_hold(qdisc_dev(sch));
+	dev_hold(dev);
 	atomic_set(&sch->refcnt, 1);
 
 	return sch;
