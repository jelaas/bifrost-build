commit 63e004efbb4625090f1100a81232eaf000c28612
Author: Robert Olsson <robert@herjulf.net>
Date:   Tue Aug 28 16:19:39 2012 +0200

    Bifrost: Accept unsupported sfp ixgbe. --ro

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fa0d6e1..b5d8ce3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -136,8 +136,8 @@ MODULE_PARM_DESC(max_vfs,
 		 "Maximum number of virtual functions to allocate per physical function - default is zero and maximum value is 63");
 #endif /* CONFIG_PCI_IOV */
 
-static unsigned int allow_unsupported_sfp;
-module_param(allow_unsupported_sfp, uint, 0);
+static unsigned int allow_unsupported_sfp = 1;
+module_param_named(allow_unsupported_sfp, allow_unsupported_sfp, uint, 0);
 MODULE_PARM_DESC(allow_unsupported_sfp,
 		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
 
