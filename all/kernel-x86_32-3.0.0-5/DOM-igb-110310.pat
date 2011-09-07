diff --git a/drivers/net/igb/igb_ethtool.c b/drivers/net/igb/igb_ethtool.c
index 78d420b..11b4711 100644
--- a/drivers/net/igb/igb_ethtool.c
+++ b/drivers/net/igb/igb_ethtool.c
@@ -34,6 +34,7 @@
 #include <linux/interrupt.h>
 #include <linux/if_ether.h>
 #include <linux/ethtool.h>
+#include <net/dom.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -2180,6 +2181,187 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	}
 }
 
+static s32 read_phy_diag(struct e1000_hw *hw, u8 page, u8 offset, u16 *data)
+{
+	struct e1000_phy_info *phy = &hw->phy;
+	s32 ret_val = -E1000_ERR_PARAM;
+
+
+	if (offset > E1000_MAX_SGMII_PHY_REG_ADDR) {
+		hw_dbg("DOM Register Address %u is out of range\n", offset);
+		return -E1000_ERR_PARAM;
+	}
+
+	ret_val = hw->phy.ops.acquire(hw);
+	if (ret_val)
+		goto out;
+
+	phy->addr = page;
+        ret_val = igb_read_phy_reg_i2c(hw, offset, data);
+
+	hw->phy.ops.release(hw);
+
+out:
+	return ret_val;
+}
+
+
+static s32 read_phy_diag_u32(struct e1000_hw *hw, u32 page, u32 offset, u32 *data)
+{
+	u16 p1 = 0, p2 = 0;
+	s32 res;
+	struct e1000_phy_info *phy = &hw->phy;
+
+	phy->addr = page;
+        res = igb_read_phy_reg_i2c(hw, offset, &p1);
+	if (res)
+		goto out;
+
+        res = igb_read_phy_reg_i2c(hw, offset+2, &p2);
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
+static int igb_get_phy_diag(struct net_device *netdev, struct ethtool_phy_diag *pd)
+{
+	struct igb_adapter *adapter = netdev_priv(netdev);
+	struct e1000_hw *hw = &adapter->hw;
+
+	int res;
+	u8 type, eo;
+	int i;
+	u32 ctrl_ext;
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
+
+	ctrl_ext = rd32(E1000_CTRL_EXT);
+        if( !(ctrl_ext & E1000_CTRL_I2C_ENA)) {
+		ctrl_ext |= E1000_CTRL_I2C_ENA;
+		wr32(E1000_CTRL_EXT, ctrl_ext);
+	}
+
+	res = read_phy_diag(hw, 0x0, DOM_A0_DOM_TYPE, &pd->type);
+
+	if (res)
+		goto out;
+
+	type = pd->type >> 8;
+
+	if ((~type & DOM_TYPE_DOM) || (type & DOM_TYPE_LEGAGY_DOM))
+		goto out;
+
+	if (type & DOM_TYPE_ADDR_CHNGE) {
+		hw_dbg("DOM module not supported (Address change)\n");
+		goto out;
+	}
+	eo = pd->type & 0xFF;
+
+	res = read_phy_diag(hw, 0x0, DOM_A0_WAVELENGTH, &pd->wavelength);
+	if (res)
+		goto out;
+
+	/* If supported. Read alarms and Warnings first*/
+	if (eo & DOM_EO_AW) {
+		res = read_phy_diag(hw, 0x1, DOM_A2_ALARM, &pd->alarm);
+		if (res)
+			goto out;
+		res = read_phy_diag(hw, 0x1, DOM_A2_WARNING, &pd->warning);
+		if (res)
+			goto out;
+	}
+
+	/* Basic diag */
+
+	for (i = 0; i < ARRAY_SIZE(basic); i++) {
+		res = read_phy_diag(hw, 0x1, basic[i].reg,
+				    (u16 *)((char *)pd + basic[i].offset));
+		if (res)
+			goto out;
+	}
+
+	/* Power */
+
+	for (i = 0; i < ARRAY_SIZE(power); i++) {
+		res = read_phy_diag_u32(hw, 0x1, power[i].reg,
+					(u32 *)((char *)pd + power[i].offset));
+		if (res)
+			goto out;
+	}
+
+	/* Thresholds for Alarms and Warnings */
+
+	if (eo & DOM_EO_AW) {
+		for (i = 0; i < ARRAY_SIZE(aw); i++) {
+			res = read_phy_diag(hw, 0x1, aw[i].reg,
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
 static const struct ethtool_ops igb_ethtool_ops = {
 	.get_settings           = igb_get_settings,
 	.set_settings           = igb_set_settings,
@@ -2214,6 +2396,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_ethtool_stats      = igb_get_ethtool_stats,
 	.get_coalesce           = igb_get_coalesce,
 	.set_coalesce           = igb_set_coalesce,
+	.get_phy_diag           = igb_get_phy_diag,
 };
 
 void igb_set_ethtool_ops(struct net_device *netdev)
