--- drivers/net/ethernet/intel/ixgbe/ixgbe_main.c.orig	Wed Mar 16 09:59:04 2016
+++ drivers/net/ethernet/intel/ixgbe/ixgbe_main.c	Wed Mar 16 10:04:11 2016
@@ -3402,13 +3402,16 @@
 	u32 i, j;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
-
+	int rss_start = 0;
+	
+	if(rss_i > 1) rss_start = 1;
+	
 	/* Program table for at least 2 queues w/ SR-IOV so that VFs can
 	 * make full use of any rings they may have.  We will use the
 	 * PSRTYPE register to control how many rings we use within the PF.
 	 */
 	if ((adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) && (rss_i < 2))
-		rss_i = 2;
+		rss_i = 2 + rss_start;
 
 	/* Fill out hash function seeds */
 	for (i = 0; i < 10; i++)
@@ -3417,9 +3420,9 @@
 	/* Fill out redirection table */
 	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
 
-	for (i = 0, j = 0; i < reta_entries; i++, j++) {
+	for (i = 0, j = rss_start; i < reta_entries; i++, j++) {
 		if (j == rss_i)
-			j = 0;
+			j = rss_start;
 
 		adapter->rss_indir_tbl[i] = j;
 	}
