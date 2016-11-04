From: Eric Dumazet <edumazet@google.com>

RAW sockets with hdrinc suffer from contention on rt_uncached_lock
spinlock.

One solution is to use percpu lists, since most routes are destroyed
by the cpu that created them.

It is unclear why we even have to put these routes in uncached_list,
as all outgoing packets should be freed when a device is dismantled.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Fixes: caacf05e5ad1 ("ipv4: Properly purge netdev references on uncached routes.")
---
 include/net/route.h |    2 +
 net/ipv4/route.c    |   46 ++++++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index b17cf28f996e..fe22d03afb6a 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -46,6 +46,7 @@
 
 struct fib_nh;
 struct fib_info;
+struct uncached_list;
 struct rtable {
 	struct dst_entry	dst;
 
@@ -64,6 +65,7 @@ struct rtable {
 	u32			rt_pmtu;
 
 	struct list_head	rt_uncached;
+	struct uncached_list	*rt_uncached_list;
 };
 
 static inline bool rt_is_input_route(const struct rtable *rt)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 6a2155b02602..ce112d0f2698 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1325,14 +1325,22 @@ static bool rt_cache_route(struct fib_nh *nh, struct rtable *rt)
 	return ret;
 }
 
-static DEFINE_SPINLOCK(rt_uncached_lock);
-static LIST_HEAD(rt_uncached_list);
+struct uncached_list {
+	spinlock_t		lock;
+	struct list_head	head;
+};
+
+static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt_uncached_list);
 
 static void rt_add_uncached_list(struct rtable *rt)
 {
-	spin_lock_bh(&rt_uncached_lock);
-	list_add_tail(&rt->rt_uncached, &rt_uncached_list);
-	spin_unlock_bh(&rt_uncached_lock);
+	struct uncached_list *ul = raw_cpu_ptr(&rt_uncached_list);
+
+	rt->rt_uncached_list = ul;
+
+	spin_lock_bh(&ul->lock);
+	list_add_tail(&rt->rt_uncached, &ul->head);
+	spin_unlock_bh(&ul->lock);
 }
 
 static void ipv4_dst_destroy(struct dst_entry *dst)
@@ -1340,27 +1348,32 @@ static void ipv4_dst_destroy(struct dst_entry *dst)
 	struct rtable *rt = (struct rtable *) dst;
 
 	if (!list_empty(&rt->rt_uncached)) {
-		spin_lock_bh(&rt_uncached_lock);
+		struct uncached_list *ul = rt->rt_uncached_list;
+
+		spin_lock_bh(&ul->lock);
 		list_del(&rt->rt_uncached);
-		spin_unlock_bh(&rt_uncached_lock);
+		spin_unlock_bh(&ul->lock);
 	}
 }
 
 void rt_flush_dev(struct net_device *dev)
 {
-	if (!list_empty(&rt_uncached_list)) {
-		struct net *net = dev_net(dev);
-		struct rtable *rt;
+	struct net *net = dev_net(dev);
+	struct rtable *rt;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
 
-		spin_lock_bh(&rt_uncached_lock);
-		list_for_each_entry(rt, &rt_uncached_list, rt_uncached) {
+		spin_lock_bh(&ul->lock);
+		list_for_each_entry(rt, &ul->head, rt_uncached) {
 			if (rt->dst.dev != dev)
 				continue;
 			rt->dst.dev = net->loopback_dev;
 			dev_hold(rt->dst.dev);
 			dev_put(dev);
 		}
-		spin_unlock_bh(&rt_uncached_lock);
+		spin_unlock_bh(&ul->lock);
 	}
 }
 
@@ -2717,6 +2730,7 @@ struct ip_rt_acct __percpu *ip_rt_acct __read_mostly;
 int __init ip_rt_init(void)
 {
 	int rc = 0;
+	int cpu;
 
 	ip_idents = kmalloc(IP_IDENTS_SZ * sizeof(*ip_idents), GFP_KERNEL);
 	if (!ip_idents)
@@ -2724,6 +2738,12 @@ int __init ip_rt_init(void)
 
 	prandom_bytes(ip_idents, IP_IDENTS_SZ * sizeof(*ip_idents));
 
+	for_each_possible_cpu(cpu) {
+		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
+
+		INIT_LIST_HEAD(&ul->head);
+		spin_lock_init(&ul->lock);
+	}
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	ip_rt_acct = __alloc_percpu(256 * sizeof(struct ip_rt_acct), __alignof__(struct ip_rt_acct));
 	if (!ip_rt_acct)


--
