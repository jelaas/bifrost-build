diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ed5f1c1..30db3c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6974,6 +6974,7 @@ static int i40e_config_rss(struct i40e_pf *pf)
 	int i, j;
 	u64 hena;
 	u32 reg_val;
+	int rss_start = 0;
 
 	/* Fill out hash function seed */
 	for (i = 0; i <= I40E_PFQF_HKEY_MAX_INDEX; i++)
@@ -6997,8 +6998,9 @@ static int i40e_config_rss(struct i40e_pf *pf)
 	}
 	wr32(hw, I40E_PFQF_CTL_0, reg_val);
 
+	if(pf->rss_size > 1) rss_start = 1;
 	/* Populate the LUT with max no. of queues in round robin fashion */
-	for (i = 0, j = 0; i < pf->rss_table_size; i++, j++) {
+	for (i = 0, j = rss_start; i < pf->rss_table_size; i++, j++) {
 
 		/* The assumption is that lan qp count will be the highest
 		 * qp count for any PF VSI that needs RSS.
@@ -7008,7 +7010,7 @@ static int i40e_config_rss(struct i40e_pf *pf)
 		 * is not necessary.
 		 */
 		if (j == pf->rss_size)
-			j = 0;
+			j = rss_start;
 		/* lut = 4-byte sliding window of 4 lut entries */
 		lut = (lut << 8) | (j &
 			 ((0x1 << pf->hw.func_caps.rss_table_entry_width) - 1));
