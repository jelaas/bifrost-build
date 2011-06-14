commit fb686d0d54a1cdb63000b2d0006c74449d6952b5
Author: Robert Olsson <robert@herjulf.net>
Date:   Mon Feb 28 15:37:35 2011 +0100

    DOM support for ixgbe added

diff --git a/drivers/net/ixgbe/ixgbe_ethtool.c b/drivers/net/ixgbe/ixgbe_ethtool.c
index 309272f..9112d2a 100644
--- a/drivers/net/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ixgbe/ixgbe_ethtool.c
@@ -35,9 +35,11 @@
 #include <linux/ethtool.h>
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>
+#include <net/dom.h>
 
 #include "ixgbe.h"
-
+#include "ixgbe_phy.h"
+#include "ixgbe_common.h"
 
 #define IXGBE_ALL_RAR_ENTRIES 16
 
@@ -2438,6 +2440,174 @@ static int ixgbe_set_rx_ntuple(struct net_device *dev,
 	return err ? -1 : 0;
 }
 
+static s32 read_phy_diag(struct ixgbe_hw *hw, u8 page, u8 offset, u16 *data)
+{
+	s32 status;
+	u8 hi, lo;
+	hi = 0; lo = 0;
+
+	status = ixgbe_read_i2c_byte_generic(hw, offset, page, &hi);
+	if (status)
+		goto out;
+
+	status = ixgbe_read_i2c_byte_generic(hw, offset+1, page, &lo);
+	if (status)
+		goto out;
+
+	*data = (((u16)hi) << 8) | lo;
+out:
+	return status;
+}
+
+static s32 read_phy_diag_u32(struct ixgbe_hw *hw, u8 page, u8 offset, u32 *data)
+{
+	u16 p1;
+	u16 p2;
+	s32 res;
+
+	res = read_phy_diag(hw, page, offset, &p1);
+	if (res)
+		goto out;
+
+	res = read_phy_diag(hw, page, offset+1, &p2);
+	if (res)
+		goto out;
+
+	*data = ((u32)p1) << 16 | p2;
+
+out:
+	return res;
+}
+
+struct reg_offset {
+	int reg;
+	size_t offset;
+};
+
+#define REG_OFFSET(a, b) \
+	{ .reg = a, .offset = offsetof(struct ethtool_phy_diag, b) }
+
+int ixgb_get_phy_diag(struct net_device *netdev, struct ethtool_phy_diag *pd)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	int res;
+	u8 type, eo;
+	int i;
+
+	static const struct reg_offset basic[] = {
+		REG_OFFSET(DOM_A2_TEMP, temp),
+		REG_OFFSET(DOM_A2_TEMP_SLOPE, temp_slope),
+		REG_OFFSET(DOM_A2_TEMP_OFFSET, temp_offset),
+		REG_OFFSET(DOM_A2_VCC, vcc),
+		REG_OFFSET(DOM_A2_VCC_SLOPE, vcc_slope),
+		REG_OFFSET(DOM_A2_VCC_OFFSET, vcc_offset),
+		REG_OFFSET(DOM_A2_TX_BIAS, tx_bias),
+		REG_OFFSET(DOM_A2_TX_I_SLOPE, tx_bias_slope),
+		REG_OFFSET(DOM_A2_TX_I_OFFSET, tx_bias_offset),
+		REG_OFFSET(DOM_A2_TX_PWR, tx_pwr),
+		REG_OFFSET(DOM_A2_TX_PWR_SLOPE, tx_pwr_slope),
+		REG_OFFSET(DOM_A2_TX_PWR_OFFSET, tx_pwr_offset),
+		REG_OFFSET(DOM_A2_RX_PWR, rx_pwr),
+	};
+
+	static const struct reg_offset power[] = {
+		REG_OFFSET(DOM_A2_RX_PWR_0, rx_pwr_cal[0]),
+		REG_OFFSET(DOM_A2_RX_PWR_1, rx_pwr_cal[1]),
+		REG_OFFSET(DOM_A2_RX_PWR_2, rx_pwr_cal[2]),
+		REG_OFFSET(DOM_A2_RX_PWR_3, rx_pwr_cal[3]),
+		REG_OFFSET(DOM_A2_RX_PWR_4, rx_pwr_cal[4]),
+	};
+
+	static const struct reg_offset aw[] = {
+		REG_OFFSET(DOM_A2_TEMP_AHT, temp_aht),
+		REG_OFFSET(DOM_A2_TEMP_ALT, temp_alt),
+		REG_OFFSET(DOM_A2_TEMP_WHT, temp_wht),
+		REG_OFFSET(DOM_A2_TEMP_WLT, temp_wlt),
+		REG_OFFSET(DOM_A2_VCC_AHT, vcc_aht),
+		REG_OFFSET(DOM_A2_VCC_ALT, vcc_alt),
+		REG_OFFSET(DOM_A2_VCC_WHT, vcc_wht),
+		REG_OFFSET(DOM_A2_VCC_WLT, vcc_wlt),
+		REG_OFFSET(DOM_A2_TX_BIAS_AHT, tx_bias_aht),
+		REG_OFFSET(DOM_A2_TX_BIAS_ALT, tx_bias_alt),
+		REG_OFFSET(DOM_A2_TX_BIAS_WHT, tx_bias_wht),
+		REG_OFFSET(DOM_A2_TX_BIAS_WLT, tx_bias_wlt),
+		REG_OFFSET(DOM_A2_TX_PWR_AHT, tx_pwr_aht),
+		REG_OFFSET(DOM_A2_TX_PWR_ALT, tx_pwr_alt),
+		REG_OFFSET(DOM_A2_TX_PWR_WHT, tx_pwr_wht),
+		REG_OFFSET(DOM_A2_TX_PWR_WLT, tx_pwr_wlt),
+		REG_OFFSET(DOM_A2_RX_PWR_AHT, rx_pwr_aht),
+		REG_OFFSET(DOM_A2_RX_PWR_ALT, rx_pwr_alt),
+		REG_OFFSET(DOM_A2_RX_PWR_WHT, rx_pwr_wht),
+		REG_OFFSET(DOM_A2_RX_PWR_WLT, rx_pwr_wlt),
+	};
+
+	res = read_phy_diag(hw, 0xA0, DOM_A0_DOM_TYPE, &pd->type);
+	if (res)
+		goto out;
+
+	type = pd->type >> 8;
+
+	if ((~type & DOM_TYPE_DOM) || (type & DOM_TYPE_LEGAGY_DOM))
+		goto out;
+
+	if (type & DOM_TYPE_ADDR_CHNGE)  {
+		hw_dbg(hw, "DOM module not supported (Address change)\n");
+		goto out;
+	}
+
+	eo = pd->type & 0xFF;
+
+	res = read_phy_diag(hw, 0xA0, DOM_A0_WAVELENGTH, &pd->wavelength);
+	if (res)
+		goto out;
+
+
+	/* If supported. Read alarms and Warnings first*/
+	if (eo & DOM_EO_AW) {
+		res = read_phy_diag(hw, 0xA2, DOM_A2_ALARM, &pd->alarm);
+		if (res)
+			goto out;
+
+		res = read_phy_diag(hw, 0xA2, DOM_A2_WARNING, &pd->warning);
+		if (res)
+			goto out;
+	}
+
+	/* Basic diag */
+
+	for (i = 0; i < ARRAY_SIZE(basic); i++) {
+		res = read_phy_diag(hw, 0xA2, basic[i].reg,
+				    (u16 *)((char *)pd + basic[i].offset));
+		if (res)
+			goto out;
+	}
+
+
+	/* Power */
+
+	for (i = 0; i < ARRAY_SIZE(power); i++) {
+		res = read_phy_diag_u32(hw, 0xA2, power[i].reg,
+					(u32 *)((char *)pd + power[i].offset));
+		if (res)
+			goto out;
+	}
+
+	/* Thresholds for Alarms and Warnings */
+
+	if (eo & DOM_EO_AW) {
+		for (i = 0; i < ARRAY_SIZE(aw); i++) {
+			res = read_phy_diag(hw, 0xA2, aw[i].reg,
+					    (u16 *)((char *)pd + aw[i].offset));
+			if (res)
+				goto out;
+		}
+	}
+
+out:
+	return res;
+}
+
 static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.get_settings           = ixgbe_get_settings,
 	.set_settings           = ixgbe_set_settings,
@@ -2474,6 +2644,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.get_flags              = ethtool_op_get_flags,
 	.set_flags              = ixgbe_set_flags,
 	.set_rx_ntuple          = ixgbe_set_rx_ntuple,
+	.get_phy_diag           = ixgb_get_phy_diag,
 };
 
 void ixgbe_set_ethtool_ops(struct net_device *netdev)
