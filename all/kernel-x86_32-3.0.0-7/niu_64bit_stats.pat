commit 1a7a10325d370e2cbed0c5bb7313904545f6dac8
Author: stephen hemminger <shemminger@vyatta.com>
Date:   Wed Jun 8 14:54:04 2011 +0000

    niu: support 64 bit stats interface
    
    Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/niu.c b/drivers/net/niu.c
index 543eb17..1c7b790 100644
--- a/drivers/net/niu.c
+++ b/drivers/net/niu.c
@@ -6249,9 +6249,10 @@ static void niu_sync_mac_stats(struct niu *np)
 		niu_sync_bmac_stats(np);
 }
 
-static void niu_get_rx_stats(struct niu *np)
+static void niu_get_rx_stats(struct niu *np,
+			     struct rtnl_link_stats64 *stats)
 {
-	unsigned long pkts, dropped, errors, bytes;
+	u64 pkts, dropped, errors, bytes;
 	struct rx_ring_info *rx_rings;
 	int i;
 
@@ -6273,15 +6274,16 @@ static void niu_get_rx_stats(struct niu *np)
 	}
 
 no_rings:
-	np->dev->stats.rx_packets = pkts;
-	np->dev->stats.rx_bytes = bytes;
-	np->dev->stats.rx_dropped = dropped;
-	np->dev->stats.rx_errors = errors;
+	stats->rx_packets = pkts;
+	stats->rx_bytes = bytes;
+	stats->rx_dropped = dropped;
+	stats->rx_errors = errors;
 }
 
-static void niu_get_tx_stats(struct niu *np)
+static void niu_get_tx_stats(struct niu *np,
+			     struct rtnl_link_stats64 *stats)
 {
-	unsigned long pkts, errors, bytes;
+	u64 pkts, errors, bytes;
 	struct tx_ring_info *tx_rings;
 	int i;
 
@@ -6300,20 +6302,22 @@ static void niu_get_tx_stats(struct niu *np)
 	}
 
 no_rings:
-	np->dev->stats.tx_packets = pkts;
-	np->dev->stats.tx_bytes = bytes;
-	np->dev->stats.tx_errors = errors;
+	stats->tx_packets = pkts;
+	stats->tx_bytes = bytes;
+	stats->tx_errors = errors;
 }
 
-static struct net_device_stats *niu_get_stats(struct net_device *dev)
+static struct rtnl_link_stats64 *niu_get_stats(struct net_device *dev,
+					       struct rtnl_link_stats64 *stats)
 {
 	struct niu *np = netdev_priv(dev);
 
 	if (netif_running(dev)) {
-		niu_get_rx_stats(np);
-		niu_get_tx_stats(np);
+		niu_get_rx_stats(np, stats);
+		niu_get_tx_stats(np, stats);
 	}
-	return &dev->stats;
+
+	return stats;
 }
 
 static void niu_load_hash_xmac(struct niu *np, u16 *hash)
@@ -9711,7 +9715,7 @@ static const struct net_device_ops niu_netdev_ops = {
 	.ndo_open		= niu_open,
 	.ndo_stop		= niu_close,
 	.ndo_start_xmit		= niu_start_xmit,
-	.ndo_get_stats		= niu_get_stats,
+	.ndo_get_stats64	= niu_get_stats,
 	.ndo_set_multicast_list	= niu_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= niu_set_mac_addr,
