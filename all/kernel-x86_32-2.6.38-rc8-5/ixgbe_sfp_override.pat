diff --git a/drivers/net/ixgbe/ixgbe_phy.c b/drivers/net/ixgbe/ixgbe_phy.c
index f72f705..a4575ad 100644
--- a/drivers/net/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ixgbe/ixgbe_phy.c
@@ -1062,6 +1062,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		if (!(enforce_sfp & IXGBE_DEVICE_CAPS_ALLOW_ANY_SFP) &&
 		    !((hw->phy.sfp_type == ixgbe_sfp_type_1g_cu_core0) ||
 		      (hw->phy.sfp_type == ixgbe_sfp_type_1g_cu_core1))) {
+		  hw->phy.type = ixgbe_phy_sfp_intel; /* Bifrost: override check */
 			/* Make sure we're a supported PHY type */
 			if (hw->phy.type == ixgbe_phy_sfp_intel) {
 				status = 0;
