--- kernel-3.3.0-rc2/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c	Tue Feb  7 10:32:25 2012
+++ kernel-3.3.0-rc2-bifrost/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c	Tue Feb  7 12:56:56 2012
@@ -2554,18 +2554,22 @@
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
