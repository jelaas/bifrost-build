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
