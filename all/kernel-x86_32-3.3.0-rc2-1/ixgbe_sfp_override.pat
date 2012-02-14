--- kernel-3.3.0-rc2/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c	Tue Feb  7 10:32:25 2012
+++ kernel-3.3.0-rc2-bifrost/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c	Tue Feb  7 12:57:01 2012
@@ -1064,6 +1064,7 @@
 		if (!(enforce_sfp & IXGBE_DEVICE_CAPS_ALLOW_ANY_SFP) &&
 		    !((hw->phy.sfp_type == ixgbe_sfp_type_1g_cu_core0) ||
 		      (hw->phy.sfp_type == ixgbe_sfp_type_1g_cu_core1))) {
+		  hw->phy.type = ixgbe_phy_sfp_intel; /* Bifrost: override check */
 			/* Make sure we're a supported PHY type */
 			if (hw->phy.type == ixgbe_phy_sfp_intel) {
 				status = 0;
