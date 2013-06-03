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
