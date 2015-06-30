--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -381,6 +381,53 @@
 	__u64	data[0];
 };
 
+/* Diagmostic Monitoring Interface Data -- DOM */
+struct ethtool_phy_diag {
+	__u32 cmd;
+	/* A0 page */
+	__u16 type;
+	__u16 wavelength;
+	/* A2 page */
+	__u16 alarm;
+	__u16 warning;
+	__s16 temp;
+	__u16 temp_slope;
+	__s16 temp_offset;
+	__u16 vcc;
+	__u16 vcc_slope;
+	__s16 vcc_offset;
+	__u16 tx_bias;
+	__u16 tx_bias_slope;
+	__s16 tx_bias_offset;
+	__u16 tx_pwr;
+	__u16 tx_pwr_slope;
+	__s16 tx_pwr_offset;
+	__u16 rx_pwr;
+	__u32 rx_pwr_cal[5];
+
+	/* Thresholds */
+	__s16 temp_alt;
+	__s16 temp_aht;
+	__s16 temp_wlt;
+	__s16 temp_wht;
+	__u16 vcc_alt;
+	__u16 vcc_aht;
+	__u16 vcc_wlt;
+	__u16 vcc_wht;
+	__u16 tx_bias_alt;
+	__u16 tx_bias_aht;
+	__u16 tx_bias_wlt;
+	__u16 tx_bias_wht;
+	__u16 tx_pwr_alt;
+	__u16 tx_pwr_aht;
+	__u16 tx_pwr_wlt;
+	__u16 tx_pwr_wht;
+	__u16 rx_pwr_alt;
+	__u16 rx_pwr_aht;
+	__u16 rx_pwr_wlt;
+	__u16 rx_pwr_wht;
+};
+
 struct ethtool_perm_addr {
 	__u32	cmd;		/* ETHTOOL_GPERMADDR */
 	__u32	size;
@@ -1000,6 +1047,7 @@
 	u32	(*get_rxfh_indir_size)(struct net_device *);
 	int	(*get_rxfh_indir)(struct net_device *, u32 *);
 	int	(*set_rxfh_indir)(struct net_device *, const u32 *);
+	int     (*get_phy_diag)(struct net_device *, struct ethtool_phy_diag *);
 	void	(*get_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*set_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*get_dump_flag)(struct net_device *, struct ethtool_dump *);
@@ -1078,6 +1126,7 @@
 #define ETHTOOL_GSSET_INFO	0x00000037 /* Get string set info */
 #define ETHTOOL_GRXFHINDIR	0x00000038 /* Get RX flow hash indir'n table */
 #define ETHTOOL_SRXFHINDIR	0x00000039 /* Set RX flow hash indir'n table */
+#define ETHTOOL_GPHYDIAG	0x00000100 /* Get PHY diagnostics */
 
 #define ETHTOOL_GFEATURES	0x0000003a /* Get device offload settings */
 #define ETHTOOL_SFEATURES	0x0000003b /* Change device offload settings */
