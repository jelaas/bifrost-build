--- kernel-3.0.0-rc5.orig/drivers/net/ixgbe/ixgbe_main.c	2011-07-12 14:40:14.000000000 +0200
+++ kernel-3.0.0-rc5/drivers/net/ixgbe/ixgbe_main.c	2011-07-13 10:15:25.777001375 +0200
@@ -2869,18 +2869,22 @@
 	int i, j;
 	u8 tcs = netdev_get_num_tc(adapter->netdev);
 	int maxq = adapter->ring_feature[RING_F_RSS].indices;
+	int rss_start = 0;
 
 	if (tcs)
 		maxq = min(maxq, adapter->num_tx_queues / tcs);
 
+	if(maxq)
+		rss_start = 1;
+
 	/* Fill out hash function seeds */
 	for (i = 0; i < 10; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RSSRK(i), seed[i]);
 
 	/* Fill out redirection table */
-	for (i = 0, j = 0; i < 128; i++, j++) {
+	for (i = 0, j = rss_start; i < 128; i++, j++) {
 		if (j == maxq)
-			j = 0;
+			j = rss_start;
 		/* reta = 4-byte sliding window of
 		 * 0x00..(indices-1)(indices-1)00..etc. */
 		reta = (reta << 8) | (j * 0x11);
