diff -ur kernel-v2.6.38-rc1.orig/drivers/net/ixgbe/ixgbe_main.c kernel-v2.6.38-rc1/drivers/net/ixgbe/ixgbe_main.c
--- kernel-v2.6.38-rc1.orig/drivers/net/ixgbe/ixgbe_main.c	2011-03-04 07:53:40.000000000 +0100
+++ kernel-v2.6.38-rc1/drivers/net/ixgbe/ixgbe_main.c	2011-03-04 08:11:46.177434959 +0100
@@ -2854,15 +2854,18 @@
 	u32 rxcsum;
 	int i, j;
 	int mask;
+	int rss_start = 0;
 
 	/* Fill out hash function seeds */
 	for (i = 0; i < 10; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RSSRK(i), seed[i]);
 
+	if(adapter->ring_feature[RING_F_RSS].indices)
+		rss_start = 1;
 	/* Fill out redirection table */
-	for (i = 0, j = 0; i < 128; i++, j++) {
+	for (i = 0, j = rss_start; i < 128; i++, j++) {
 		if (j == adapter->ring_feature[RING_F_RSS].indices)
-			j = 0;
+			j = rss_start;
 		/* reta = 4-byte sliding window of
 		 * 0x00..(indices-1)(indices-1)00..etc. */
 		reta = (reta << 8) | (j * 0x11);
Binary files kernel-v2.6.38-rc1.orig/.git/index and kernel-v2.6.38-rc1/.git/index differ
