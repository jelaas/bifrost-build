--- ethtool-v3.6-orig/ethtool-copy.h	Thu Feb  7 11:20:12 2013
+++ ethtool-v3.6/ethtool-copy.h	Thu Feb  7 11:27:01 2013
@@ -409,6 +409,53 @@
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
+  	__s16 temp_alt;
+  	__s16 temp_aht;
+  	__s16 temp_wlt;
+  	__s16 temp_wht;
+  	__u16 vcc_alt;
+  	__u16 vcc_aht;
+  	__u16 vcc_wlt;
+  	__u16 vcc_wht;
+  	__u16 tx_bias_alt;
+  	__u16 tx_bias_aht;
+  	__u16 tx_bias_wlt;
+  	__u16 tx_bias_wht;
+  	__u16 tx_pwr_alt;
+  	__u16 tx_pwr_aht;
+  	__u16 tx_pwr_wlt;
+  	__u16 tx_pwr_wht;
+  	__u16 rx_pwr_alt;
+  	__u16 rx_pwr_aht;
+  	__u16 rx_pwr_wlt;
+  	__u16 rx_pwr_wht;
+};
+
 struct ethtool_perm_addr {
 	__u32	cmd;		/* ETHTOOL_GPERMADDR */
 	__u32	size;
@@ -886,6 +933,8 @@
 #define ETHTOOL_GMODULEEEPROM	0x00000043 /* Get plug-in module eeprom */
 #define ETHTOOL_GEEE		0x00000044 /* Get EEE settings */
 #define ETHTOOL_SEEE		0x00000045 /* Set EEE settings */
+
+#define ETHTOOL_GPHYDIAG        0x00000100 /* Get PHY diagnostics (DOM)*/
 
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
Only in ethtool-v3.6: ethtool-copy.h~
--- ethtool-v3.6-orig/ethtool.c	Thu Feb  7 11:20:12 2013
+++ ethtool-v3.6/ethtool.c	Thu Feb  7 12:00:17 2013
@@ -20,6 +20,7 @@
  *	Copyright 2009, 2010 Solarflare Communications
  * MDI-X set support by Jesse Brandeburg <jesse.brandeburg@intel.com>
  *	Copyright 2012 Intel Corporation
+ * Diagnostic Monitoring Interface Support by Robert Olsson <robert@herjulf.se>
  *
  * TODO:
  *   * show settings for all devices
@@ -27,6 +28,7 @@
 
 #include "internal.h"
 #include <string.h>
+#include <math.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 #include <stdio.h>
@@ -43,6 +45,8 @@
 #include <arpa/inet.h>
 
 #include <linux/sockios.h>
+#include "dom.h"
+static int do_phy_diag(struct cmd_context *ctx);
 
 #ifndef MAX_ADDR_LEN
 #define MAX_ADDR_LEN	32
@@ -1520,6 +1524,275 @@
 #endif
 }
 
+static int do_phy_diag(struct cmd_context *ctx)
+{
+	struct ifreq *ifr = &ctx->ifr;
+	int fd = ctx->fd;
+	int err, ecal = 0, aw = 0;
+	double tmp, alt=0, aht=0, wlt=0, wht=0;
+	__u8 type, option, alarm[2] = {0,0} , warn[2] = {0,0};
+	float *f[5];
+	double s, o;
+
+	struct ethtool_phy_diag pd;
+
+	pd.cmd = ETHTOOL_GPHYDIAG;
+	ifr->ifr_data = (caddr_t)&pd;
+	err = ioctl(fd, SIOCETHTOOL, ifr);
+	if (err < 0) {
+		perror("Cannot get PHY diagnostics");
+		return 0;
+	}
+	
+	type = pd.type >> 8;
+
+	if( ~(type) & DOM_TYPE_DOM || type & DOM_TYPE_LEGAGY_DOM) {
+	  	fprintf(stdout, "PHY Diagnostics not supported:\n");
+		return 0;
+	}
+
+	if(type & DOM_TYPE_INT_CAL)
+		fprintf(stdout, "Int-Calbr: ");
+	
+	if(type & DOM_TYPE_EXT_CAL) {
+		fprintf(stdout, "Ext-Calbr: ");
+		ecal = 1;
+	}
+
+	if(type & DOM_TYPE_RX_PWR)
+		fprintf(stdout, "Avr RX-Power: ");
+	else
+		fprintf(stdout, "OMA RX-Power: ");
+	
+	if(type & DOM_TYPE_ADDR_CHNGE)
+		fprintf(stdout,"Addr Change: ");
+
+	/* Check options */
+	option = pd.type & 0x00FF;	
+
+	if(option & DOM_EO_AW) {
+		fprintf(stdout, "Alarm & Warn: ");
+		aw = 1;
+	}
+
+	if(option & DOM_EO_TX_DISABLE)
+		fprintf(stdout, "TX_DISABLE: ");
+	
+	if(option & DOM_EO_TX_FAULT)
+		fprintf(stdout, "TX_FAULT: ");
+	
+	if(option & DOM_EO_RX_LOS)
+		fprintf(stdout, "RX_LOS: ");
+	
+	if(option & DOM_EO_RATE_SELECT_MON)
+		fprintf(stdout, "RATE_SELECT MON: ");
+
+	if(option & DOM_EO_APP_SELECT)
+		fprintf(stdout, "RATE_SELECT: ");
+	
+	if(option & DOM_EO_RATE_SELECT)
+		fprintf(stdout, "RATE_SELECT: ");
+	
+	if(aw) {
+		alarm[0] = pd.alarm >> 8;
+		alarm[1] = pd.alarm & 0x00FF;
+
+		warn[0] = pd.warning >> 8;
+		warn[1] = pd.warning & 0x00FF;
+	}
+	
+	fprintf(stdout, "\tWavelength: %d nm\n", pd.wavelength); 
+
+	if(aw)
+	  fprintf(stdout, "Alarms, warnings in beginning of line, Ie. AH = Alarm High, WL == Warn Low etc\n");
+
+
+#define ECAL(v, s, o) (( ((double) (s >> 8)) + ((s & 0xFF) >> 8)) * (double) v + o)
+
+	/* Temp */
+
+	if (ecal) {
+		tmp = ECAL(pd.temp, pd.temp_slope, pd.temp_offset);
+	} else {
+		tmp =  (double) (pd.temp);
+	}
+
+	if(aw) {
+		alt = ECAL(pd.temp_alt, pd.temp_slope, pd.temp_offset);
+		aht = ECAL(pd.temp_aht, pd.temp_slope, pd.temp_offset);
+		wlt = ECAL(pd.temp_wlt, pd.temp_slope, pd.temp_offset);
+		wht = ECAL(pd.temp_wht, pd.temp_slope, pd.temp_offset);
+
+		if(alarm[0] & DOM_TYPE_TEMP_AH)
+			fprintf(stdout, "AH");
+		
+		if(alarm[0] & DOM_TYPE_TEMP_AL)
+			fprintf(stdout, "AL");
+		
+		if(warn[0] & DOM_TYPE_TEMP_WH)
+			fprintf(stdout, "WH");
+		
+		if(warn[0] & DOM_TYPE_TEMP_WL)
+			fprintf(stdout, "WL");
+	}
+	fprintf(stdout, "\tTemp: %5.1f C", tmp/256);
+	if(aw)
+		fprintf(stdout, "\t\t\tThresh: Lo: %5.1f/%-5.1f  Hi: %5.1f/%-5.1f C\n",
+			alt/256, wlt/256, wht/256, aht/256);
+	else
+		fprintf(stdout, "\n");
+
+
+
+	/* VCC */
+
+	if (ecal) {
+		tmp = ECAL(pd.vcc, pd.vcc_slope, pd.vcc_offset);
+
+	} else {
+		tmp =  (double) (pd.vcc);
+	}
+	
+	fprintf(stdout, "\tVcc: %5.2f V\t", tmp/10000);
+	alt = ECAL(pd.vcc_alt, pd.vcc_slope, pd.temp_offset);
+	aht = ECAL(pd.vcc_aht, pd.vcc_slope, pd.temp_offset);
+	wlt = ECAL(pd.vcc_wlt, pd.vcc_slope, pd.temp_offset);
+	wht = ECAL(pd.vcc_wht, pd.vcc_slope, pd.temp_offset);
+ 
+	fprintf(stdout, "\t\tThresh: Lo: %5.1f/%-5.1f  Hi: %5.1f/%-5.1f V\n",
+		alt/10000, wlt/10000, wht/10000, aht/10000);
+
+	/* TX BIAS */
+
+	if (ecal) {
+		tmp = ECAL(pd.tx_bias, pd.tx_bias_slope, pd.tx_bias_offset);
+	} else {
+		tmp =  (double) (pd.tx_bias); 
+	}
+	
+	if(aw) {
+		alt = ECAL(pd.tx_bias_alt, pd.tx_bias_slope, pd.temp_offset);
+		aht = ECAL(pd.tx_bias_aht, pd.tx_bias_slope, pd.temp_offset);
+		wlt = ECAL(pd.tx_bias_wlt, pd.tx_bias_slope, pd.temp_offset);
+		wht = ECAL(pd.tx_bias_wht, pd.tx_bias_slope, pd.temp_offset);
+  
+		if(alarm[0] & DOM_TYPE_TX_BIAS_AH)
+			fprintf(stdout, "AH");
+		
+		if(alarm[0] & DOM_TYPE_TX_BIAS_AL)
+			fprintf(stdout, "AL");
+		
+		if(warn[0] & DOM_TYPE_TX_BIAS_WH)
+			fprintf(stdout, "WH");
+		
+		if(warn[0] & DOM_TYPE_TX_BIAS_WL)
+			fprintf(stdout, "WL");
+		
+	}
+	fprintf(stdout, "\tTx-Bias: %5.1f mA\t", tmp/500);
+	if(aw)
+		fprintf(stdout, "\tThresh: Lo: %5.1f/%-5.1f  Hi: %5.1f/%-5.1f mA\n",
+			alt/500, wlt/500, wht/500, aht/500);
+
+	else
+		fprintf(stdout, "\n");
+
+
+	/* TX PWR */
+	if (ecal) {
+		tmp = ECAL(pd.tx_pwr, pd.tx_pwr_slope, pd.tx_pwr_offset);
+	} else {
+		tmp =  (double) (pd.tx_pwr);
+	}
+
+	if(aw) {
+		alt = ECAL(pd.tx_pwr_alt, pd.tx_pwr_slope, pd.temp_offset);
+		aht = ECAL(pd.tx_pwr_aht, pd.tx_pwr_slope, pd.temp_offset);
+		wlt = ECAL(pd.tx_pwr_wlt, pd.tx_pwr_slope, pd.temp_offset);
+		wht = ECAL(pd.tx_pwr_wht, pd.tx_pwr_slope, pd.temp_offset);
+	  
+		if(alarm[0] & DOM_TYPE_TX_PWR_AH)
+			fprintf(stdout, "AH");
+		
+		if(alarm[0] & DOM_TYPE_TX_PWR_AL)
+			fprintf(stdout, "AL");
+		
+		if(warn[0] & DOM_TYPE_TX_PWR_WH)
+			fprintf(stdout, "WH");
+		
+		if(warn[0] & DOM_TYPE_TX_PWR_WL)
+			fprintf(stdout, "WL");
+		
+	}
+	tmp = tmp/10000; 
+	fprintf(stdout, "\tTX-pwr: %5.1f dBm (%5.2f mW)", 10*log10(tmp), tmp);	
+	if(aw) {
+		alt = alt/10000;
+		aht = aht/10000;
+		wlt = wlt/10000;
+		wht = wht/10000;
+		fprintf(stdout, "\tThresh: Lo: %5.1f/%-5.1f  Hi: %5.1f/%-5.1f dBm\n",
+			10*log10(alt), 10*log10(wlt), 10*log10(wht), 10*log10(aht));
+	}
+	else
+		fprintf(stdout, "\n");
+
+	/* RX PWR */
+
+	/* Note factors is in float cast to avoid conversion */
+	f[0] = (float *) &pd.rx_pwr_cal[0];
+	f[1] = (float *) &pd.rx_pwr_cal[1];
+	f[2] = (float *) &pd.rx_pwr_cal[2];
+	f[3] = (float *) &pd.rx_pwr_cal[3];
+	f[4] = (float *) &pd.rx_pwr_cal[4];
+	s = *f[4] + *f[3] + *f[2] + *f[1];
+	o = *f[0];
+
+	if (ecal)
+		
+		tmp = pd.rx_pwr * s + o;
+	else
+		tmp =  (double) (pd.rx_pwr);
+
+	if(aw) {
+		alt = pd.rx_pwr_alt * s + o;
+		aht = pd.rx_pwr_aht * s + o;
+		wlt = pd.rx_pwr_wlt * s + o;
+		wht = pd.rx_pwr_wht * s + o;
+	  
+		if(alarm[1] & DOM_TYPE_RX_PWR_AH)
+			fprintf(stdout, "AH");
+		
+		if(alarm[1] & DOM_TYPE_RX_PWR_AL)
+			fprintf(stdout, "AL");
+		
+		if(warn[1] & DOM_TYPE_RX_PWR_WH)
+			fprintf(stdout, "WH");
+		
+		if(warn[1] & DOM_TYPE_RX_PWR_WL)
+			fprintf(stdout, "WL");
+		
+	}
+
+	tmp =  (double) (tmp)/10000; 
+	fprintf(stdout, "\tRX-pwr: %5.1f dBm (%5.2f mW) ", 10*log10(tmp), tmp);
+
+	if(aw) {
+		alt = alt/10000;
+		aht = aht/10000;
+		wlt = wlt/10000;
+		wht = wht/10000;
+		
+		fprintf(stdout, "\tThresh: Lo: %5.1f/%-5.1f  Hi: %5.1f/%-5.1f dBm\n",
+			10*log10(alt), 10*log10(wlt), 10*log10(wht), 10*log10(aht));
+	}
+	else 
+		fprintf(stdout, "\n");
+
+	return 0;
+}
+
+
 static int do_gdrv(struct cmd_context *ctx)
 {
 	int err;
@@ -3770,6 +4043,7 @@
 	{ "-t|--test", 1, do_test, "Execute adapter self test",
 	  "               [ online | offline | external_lb ]\n" },
 	{ "-S|--statistics", 1, do_gstats, "Show adapter statistics" },
+        { "-D|--phy_diag", 1, do_phy_diag, "Show PHY diagnostics (DOM)" },
 	{ "-n|-u|--show-nfc|--show-ntuple", 1, do_grxclass,
 	  "Show Rx network flow classification options or rules",
 	  "		[ rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
