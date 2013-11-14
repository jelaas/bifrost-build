--- kernel-3.0.0-rc7.orig/net/core/ethtool.c	2011-07-18 09:26:56.000000000 +0200
+++ kernel-3.0.0-rc7/net/core/ethtool.c	2011-07-18 10:51:34.038027267 +0200
@@ -1542,6 +1542,21 @@
 	return dev->ethtool_ops->flash_device(dev, &efl);
 }
 
+static int ethtool_phy_diag(struct net_device *dev, void __user *useraddr)
+{
+	struct ethtool_phy_diag pd;
+	
+	if (!dev->ethtool_ops->get_phy_diag)
+		return -EOPNOTSUPP;
+	
+	dev->ethtool_ops->get_phy_diag(dev, &pd);
+	
+	if (copy_to_user(useraddr, &pd, sizeof(pd)))
+		return -EFAULT;
+	
+	return 0;
+}
+
 static int ethtool_set_dump(struct net_device *dev,
 			void __user *useraddr)
 {
@@ -1836,6 +1851,9 @@
 	case ETHTOOL_SCHANNELS:
 		rc = ethtool_set_channels(dev, useraddr);
 		break;
+	case ETHTOOL_GPHYDIAG:
+		rc = ethtool_phy_diag(dev, useraddr);
+		break;
 	case ETHTOOL_SET_DUMP:
 		rc = ethtool_set_dump(dev, useraddr);
 		break;
