--- drivers/net/ethernet/intel/ixgbe/ixgbe_main.c.orig	Wed Oct  3 10:13:37 2012
+++ drivers/net/ethernet/intel/ixgbe/ixgbe_main.c	Wed Oct  3 10:16:35 2012
@@ -2890,7 +2890,11 @@
 	u32 rxcsum;
 	int i, j;
 	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
+	int rss_start = 0;
 
+	if(rss_i)
+		rss_start = 1;
+
 	/*
 	 * Program table for at least 2 queues w/ SR-IOV so that VFs can
 	 * make full use of any rings they may have.  We will use the
@@ -2904,9 +2908,9 @@
 		IXGBE_WRITE_REG(hw, IXGBE_RSSRK(i), seed[i]);
 
 	/* Fill out redirection table */
-	for (i = 0, j = 0; i < 128; i++, j++) {
+	for (i = 0, j = rss_start; i < 128; i++, j++) {
 		if (j == rss_i)
-			j = 0;
+			j = rss_start;
 		/* reta = 4-byte sliding window of
 		 * 0x00..(indices-1)(indices-1)00..etc. */
 		reta = (reta << 8) | (j * 0x11);
