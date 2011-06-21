commit 3cd8ef4b6071834fd432bbccbec0611591908643
Author: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Date:   Sun Apr 17 00:15:47 2011 +0000

    net: niu: convert to hw_features
    
    Side effect: allow toggling of TX offloads.
    
    Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/niu.c b/drivers/net/niu.c
index ea2272f..a707217 100644
--- a/drivers/net/niu.c
+++ b/drivers/net/niu.c
@@ -7913,11 +7913,6 @@ static int niu_set_phys_id(struct net_device *dev,
 	return 0;
 }
 
-static int niu_set_flags(struct net_device *dev, u32 data)
-{
-	return ethtool_op_set_flags(dev, data, ETH_FLAG_RXHASH);
-}
-
 static const struct ethtool_ops niu_ethtool_ops = {
 	.get_drvinfo		= niu_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -7934,8 +7929,6 @@ static const struct ethtool_ops niu_ethtool_ops = {
 	.set_phys_id		= niu_set_phys_id,
 	.get_rxnfc		= niu_get_nfc,
 	.set_rxnfc		= niu_set_nfc,
-	.set_flags		= niu_set_flags,
-	.get_flags		= ethtool_op_get_flags,
 };
 
 static int niu_ldg_assign_ldn(struct niu *np, struct niu_parent *parent,
@@ -9764,8 +9757,8 @@ static void __devinit niu_device_announce(struct niu *np)
 
 static void __devinit niu_set_basic_features(struct net_device *dev)
 {
-	dev->features |= (NETIF_F_SG | NETIF_F_HW_CSUM |
-			  NETIF_F_GRO | NETIF_F_RXHASH);
+	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXHASH;
+	dev->features |= dev->hw_features | NETIF_F_RXCSUM;
 }
 
 static int __devinit niu_pci_init_one(struct pci_dev *pdev,
