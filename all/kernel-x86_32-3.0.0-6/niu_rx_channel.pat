--- drivers/net/niu.h~	2011-03-16 19:50:55.000000000 +0100
+++ drivers/net/niu.h	2011-06-18 21:50:08.646067989 +0200
@@ -3287,6 +3287,7 @@
 	struct work_struct		reset_task;
 
 	u8				port;
+	u8				first_rx_channel;
 	u8				mac_xcvr;
 #define MAC_XCVR_MII			1
 #define MAC_XCVR_PCS			2
--- drivers/net/niu.c.orig	2011-06-16 21:53:55.720057697 +0200
+++ drivers/net/niu.c	2011-06-18 21:51:52.824067995 +0200
@@ -3521,7 +3521,7 @@
 	rp->rx_bytes += skb->len;
 
 	skb->protocol = eth_type_trans(skb, np->dev);
-	skb_record_rx_queue(skb, rp->rx_channel);
+	skb_record_rx_queue(skb, rp->rx_channel - np->first_rx_channel);
 	napi_gro_receive(napi, skb);
 
 	return num_rcr;
@@ -4501,6 +4501,8 @@
 		first_tx_channel += parent->txchan_per_port[i];
 	}
 
+	np->first_rx_channel = first_rx_channel;
+
 	num_rx_rings = parent->rxchan_per_port[port];
 	num_tx_rings = parent->txchan_per_port[port];
 
