--- kernel-3.3.0-rc2/drivers/net/ethernet/sun/niu.c	Tue Feb  7 10:32:26 2012
+++ kernel-3.3.0-rc2-bifrost/drivers/net/ethernet/sun/niu.c	Tue Feb  7 12:56:06 2012
@@ -3462,6 +3462,8 @@
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
 			else
 				skb_checksum_none_assert(skb);
+			if (!(val & RCR_ENTRY_MULTI))
+				append_size = len + sizeof(*rh);
 		} else if (!(val & RCR_ENTRY_MULTI))
 			append_size = len - skb->len;
 
@@ -3499,7 +3501,7 @@
 	rp->rx_bytes += skb->len;
 
 	skb->protocol = eth_type_trans(skb, np->dev);
-	skb_record_rx_queue(skb, rp->rx_channel);
+	skb_record_rx_queue(skb, rp->rx_channel - np->first_rx_channel);
 	napi_gro_receive(napi, skb);
 
 	return num_rcr;
@@ -4486,6 +4488,8 @@
 		first_rx_channel += parent->rxchan_per_port[i];
 		first_tx_channel += parent->txchan_per_port[i];
 	}
+
+	np->first_rx_channel = first_rx_channel;
 
 	num_rx_rings = parent->rxchan_per_port[port];
 	num_tx_rings = parent->txchan_per_port[port];
--- kernel-3.3.0-rc2/drivers/net/ethernet/sun/niu.h	Tue Feb  7 10:32:26 2012
+++ kernel-3.3.0-rc2-bifrost/drivers/net/ethernet/sun/niu.h	Tue Feb  7 12:56:06 2012
@@ -3288,6 +3288,7 @@
 	struct work_struct		reset_task;
 
 	u8				port;
+	u8				first_rx_channel;
 	u8				mac_xcvr;
 #define MAC_XCVR_MII			1
 #define MAC_XCVR_PCS			2
