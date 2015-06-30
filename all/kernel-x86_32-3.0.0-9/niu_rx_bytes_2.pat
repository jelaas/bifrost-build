--- drivers/net/niu.c.orig	2011-06-16 21:53:55.720057697 +0200
+++ drivers/net/niu.c	2011-06-19 11:49:17.678070991 +0200
@@ -3484,6 +3484,8 @@
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
 			else
 				skb_checksum_none_assert(skb);
+			if (!(val & RCR_ENTRY_MULTI))
+				append_size = len + sizeof(*rh);
 		} else if (!(val & RCR_ENTRY_MULTI))
 			append_size = len - skb->len;
 
