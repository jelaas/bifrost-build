commit 261eba805c1c8a9c9d36828340dcf9c8a78bea61
Author: Robert Olsson <robert@herjulf.net>
Date:   Mon Feb 28 14:28:49 2011 +0100

    DOM core patch

diff --git a/Documentation/networking/dom.txt b/Documentation/networking/dom.txt
new file mode 100644
index 0000000..4bf24de
--- /dev/null
+++ b/Documentation/networking/dom.txt
@@ -0,0 +1,41 @@
+Diagnostic Monitoring Interface Monitoring also called DOM is a specification
+for optical transceivers to allow link and other diagnostics related to the
+transceiver's to standardized and communicated. For communication the I2C
+bus is used. The SFF specifications is available at ftp://ftp.seagate.com/
+Specification is generic and should work for many types of optical modules
+as GBIC, SFP, SFp+, XFP etc
+
+In short DOM spec adds a memory page where the diagnostics's is kept (address
+0xA2 bytes 66 to 105) but there are lot's of option's and variants. For example
+alarm and warnings are optional. See example below.
+
+Not all SFP's (SFP is for GIGE) have DOM support normally long range supports
+DOM. And of course your board and driver needs this support too.
+For SFP+ (10G) DOM is mandatory.
+
+Linux kernel support is via ethertool.
+
+include/net/dom.h        # Basic definitions
+net/core/ethtool.c       # adds ethtool_phy_diag()
+include/linux/ethtool.h  # adds ETHTOOL_GPHYDIAG
+
+And drivers hooks exists currently in igb and ixgbe driver
+
+Usage example: ethtool -D eth5
+
+Ext-Calbr: Avr RX-Power: Alarm & Warn: RX_LOS: 	Wavelength: 1310 nm
+Alarms, warnings in beginning of line, Ie. AH = Alarm High, WL == Warn Low etc
+	Temp:  35.9 C			Thresh: Lo: -12.0/-8.0   Hi: 103.0/110.0 C
+	Vcc:  3.33 V			Thresh: Lo:   3.0/3.0    Hi:   3.7/4.0   V
+	Tx-Bias:  13.4 mA		Thresh: Lo:   2.0/4.0    Hi:  70.0/84.0  mA
+ALWL	TX-pwr:  -5.9 dBm ( 0.26 mW)	Thresh: Lo:  -4.0/-2.0   Hi:   7.0/8.2   dBm
+AHWH	RX-pwr:  -5.0 dBm ( 0.31 mW) 	Thresh: Lo: -35.2/-28.0  Hi:  -8.2/-6.0  dBm
+
+
+First line shows the options supported by the module. As we see this module
+supports Alarms and warnings as a consequence thresholds are printed. As example
+RX-pwr: -35.2 < no_alarm < -6.0 dBm and -28.0 < no_warning < -8.2 dBm. (dBm yields
+1 mW == 0 dBm)
+
+In the example above we see both warnings for both TX-pwr (low) and RX-Pwr high.
+The Rx side would need some attenuation.
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index aac3e2e..215f8b3 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -294,6 +294,53 @@ struct ethtool_stats {
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
@@ -764,6 +811,7 @@ struct ethtool_ops {
 				  struct ethtool_rxfh_indir *);
 	int	(*set_rxfh_indir)(struct net_device *,
 				  const struct ethtool_rxfh_indir *);
+	int	(*get_phy_diag)(struct net_device *, struct ethtool_phy_diag *);
 };
 #endif /* __KERNEL__ */
 
@@ -829,6 +877,7 @@ struct ethtool_ops {
 #define ETHTOOL_GSSET_INFO	0x00000037 /* Get string set info */
 #define ETHTOOL_GRXFHINDIR	0x00000038 /* Get RX flow hash indir'n table */
 #define ETHTOOL_SRXFHINDIR	0x00000039 /* Set RX flow hash indir'n table */
+#define ETHTOOL_GPHYDIAG	0x00000100 /* Get PHY diagnostics */
 
 #define ETHTOOL_GFEATURES	0x0000003a /* Get device offload settings */
 #define ETHTOOL_SFEATURES	0x0000003b /* Change device offload settings */
diff --git a/include/net/dom.h b/include/net/dom.h
new file mode 100644
index 0000000..61540c3
--- /dev/null
+++ b/include/net/dom.h
@@ -0,0 +1,109 @@
+#ifndef _LINUX_DOM_H
+#define _LINUX_DOM_H
+
+/*
+   Diagnostic Monitoring Interface for Optical Tranceivers
+   SFF-8472 v. 10.4 (Jan 2009)
+   ftp://ftp.seagate.com/sff/SFF-8472.PDF
+
+   Licensce GPL. Copyright Robert Olsson robert@herjulf.net
+*/
+
+#define  DOM_A0_IDENTIFIER  0
+#define  DOM_A0_WAVELENGTH 60
+#define  DOM_A0_CC_BASE    63
+#define  DOM_A0_DOM_TYPE   92
+
+/* DOM_TYPE codings in DOM_A0_DOM_TYPE */
+#define     DOM_TYPE_LEGAGY_DOM     (1<<7)
+#define     DOM_TYPE_DOM            (1<<6)  /* Has DOM support */
+#define     DOM_TYPE_INT_CAL        (1<<5)  /* Internally calibrated */
+#define     DOM_TYPE_EXT_CAL        (1<<4)  /* Externally calibrated */
+#define     DOM_TYPE_RX_PWR         (1<<3)  /* Received Power OMA=0,  1=average */
+#define     DOM_TYPE_ADDR_CHNGE     (1<<2)  /* Address change required */
+
+#define  DOM_A0_EO   93                     /* Enhanced options */
+#define     DOM_EO_AW               (1<<7)  /* Alarm & Warnings */
+#define     DOM_EO_TX_DISABLE       (1<<6)
+#define     DOM_EO_TX_FAULT         (1<<5)
+#define     DOM_EO_RX_LOS           (1<<4)
+#define     DOM_EO_RATE_SELECT_MON  (1<<3)
+#define     DOM_EO_APP_SELECT       (1<<2)
+#define     DOM_EO_RATE_SELECT      (1<<1)
+
+#define  DOM_A0_CC_EXT     95
+
+#define  DOM_A2_TEMP_AHT    0  /* Temp alarm high threshold */
+#define  DOM_A2_TEMP_ALT    2
+#define  DOM_A2_TEMP_WHT    4  /* Temp warning high threshold */
+#define  DOM_A2_TEMP_WLT    6
+
+#define  DOM_A2_VCC_AHT    8  /* VCC alarm high threshold */
+#define  DOM_A2_VCC_ALT   10
+#define  DOM_A2_VCC_WHT   12  /* VCC warning high threshold */
+#define  DOM_A2_VCC_WLT   14
+
+#define  DOM_A2_TX_BIAS_AHT   16  /* TX_BIAS alarm high threshold */
+#define  DOM_A2_TX_BIAS_ALT   18
+#define  DOM_A2_TX_BIAS_WHT   20  /* TX_BIAS warning high threshold */
+#define  DOM_A2_TX_BIAS_WLT   22
+
+#define  DOM_A2_TX_PWR_AHT   24  /* TX_PWR alarm high threshold */
+#define  DOM_A2_TX_PWR_ALT   26
+#define  DOM_A2_TX_PWR_WHT   28  /* TX_PWR warning high threshold */
+#define  DOM_A2_TX_PWR_WLT   30
+
+#define  DOM_A2_RX_PWR_AHT   32  /* RX_PWR alarm high threshold */
+#define  DOM_A2_RX_PWR_ALT   34
+#define  DOM_A2_RX_PWR_WHT   36  /* RX_PWR warning high threshold */
+#define  DOM_A2_RX_PWR_WLT   38
+
+#define  DOM_A2_RX_PWR_4   56  /* 4 bytes  Calibration constants*/
+#define  DOM_A2_RX_PWR_3   60  /* 4 bytes */
+#define  DOM_A2_RX_PWR_2   64  /* 4 bytes */
+#define  DOM_A2_RX_PWR_1   68  /* 4 bytes */
+#define  DOM_A2_RX_PWR_0   72  /* 4 bytes */
+
+#define  DOM_A2_TX_I_SLOPE   76  /* 2 bytes */
+#define  DOM_A2_TX_I_OFFSET  78  /* 2 bytes */
+#define  DOM_A2_TX_PWR_SLOPE   80  /* 2 bytes */
+#define  DOM_A2_TX_PWR_OFFSET  82  /* 2 bytes */
+#define  DOM_A2_TEMP_SLOPE   84  /* 2 bytes */
+#define  DOM_A2_TEMP_OFFSET  86  /* 2 bytes */
+#define  DOM_A2_VCC_SLOPE   88  /* 2 bytes */
+#define  DOM_A2_VCC_OFFSET  90  /* 2 bytes */
+
+#define  DOM_A2_CC_DMI    95
+#define  DOM_A2_TEMP      96   /* 2 bytes */
+#define  DOM_A2_VCC       98   /* 2 bytes */
+#define  DOM_A2_TX_BIAS  100   /* 2 bytes */
+#define  DOM_A2_TX_PWR   102   /* 2 bytes */
+#define  DOM_A2_RX_PWR   104   /* 2 bytes */
+
+#define  DOM_A2_ALARM    112   /* 2 bytes */
+#define     DOM_TYPE_TEMP_AH       (1<<7)  /* Temp alarm high */
+#define     DOM_TYPE_TEMP_AL       (1<<6)  /* low */
+#define     DOM_TYPE_VCC_AH        (1<<5)
+#define     DOM_TYPE_VCC_AL        (1<<4)
+#define     DOM_TYPE_TX_BIAS_AH    (1<<3)
+#define     DOM_TYPE_TX_BIAS_AL    (1<<2)
+#define     DOM_TYPE_TX_PWR_AH     (1<<1)
+#define     DOM_TYPE_TX_PWR_AL     (1<<0)
+/* Next byte 113 */
+#define     DOM_TYPE_RX_PWR_AH     (1<<7)
+#define     DOM_TYPE_RX_PWR_AL     (1<<6)
+
+#define  DOM_A2_WARNING  116   /* 2 bytes */
+#define     DOM_TYPE_TEMP_WH       (1<<7)  /* Temp warning high */
+#define     DOM_TYPE_TEMP_WL       (1<<6)  /* low */
+#define     DOM_TYPE_VCC_WH        (1<<5)
+#define     DOM_TYPE_VCC_WL        (1<<4)
+#define     DOM_TYPE_TX_BIAS_WH    (1<<3)
+#define     DOM_TYPE_TX_BIAS_WL    (1<<2)
+#define     DOM_TYPE_TX_PWR_WH     (1<<1)
+#define     DOM_TYPE_TX_PWR_WL     (1<<0)
+/* Next byte 117 */
+#define     DOM_TYPE_RX_PWR_WH     (1<<7)
+#define     DOM_TYPE_RX_PWR_WL     (1<<6)
+
+#endif /* _LINUX_DOM_H */
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index c1a71bb..2ee5167 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1725,6 +1725,21 @@ static noinline_for_stack int ethtool_flash_device(struct net_device *dev,
 	return dev->ethtool_ops->flash_device(dev, &efl);
 }
 
+static int ethtool_phy_diag(struct net_device *dev, void __user *useraddr)
+{
+	struct ethtool_phy_diag pd;
+
+	if (!dev->ethtool_ops->get_phy_diag)
+		return -EOPNOTSUPP;
+
+	dev->ethtool_ops->get_phy_diag(dev, &pd); /* FIXME */
+
+	if (copy_to_user(useraddr, &pd, sizeof(pd)))
+		 return -EFAULT;
+
+	return 0;
+}
+
 /* The main entry point in this file.  Called from net/core/dev.c */
 
 int dev_ethtool(struct net *net, struct ifreq *ifr)
@@ -1935,6 +1950,9 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_SGRO:
 		rc = ethtool_set_one_feature(dev, useraddr, ethcmd);
 		break;
+	case ETHTOOL_GPHYDIAG:
+		rc = ethtool_phy_diag(dev, useraddr);
+		break;
 	default:
 		rc = -EOPNOTSUPP;
 	}
