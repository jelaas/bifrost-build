diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 9ded8c6..a95bf28 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -92,6 +92,7 @@ int ethtool_op_get_ts_info(struct net_device *dev, struct ethtool_ts_info *eti);
  */
 static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 {
+        if(n_rx_rings > 1) return (index % (n_rx_rings - 1)) + 1;
 	return index % n_rx_rings;
 }
 
