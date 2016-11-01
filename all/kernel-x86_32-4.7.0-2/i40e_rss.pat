--- drivers/net/ethernet/intel/i40e/i40e_main.c.orig	Wed Mar 16 10:06:53 2016
+++ drivers/net/ethernet/intel/i40e/i40e_main.c	Wed Mar 16 10:26:08 2016
@@ -8051,9 +8051,15 @@
 			      u16 rss_table_size, u16 rss_size)
 {
 	u16 i;
+	u16 rss_offset = 0;
 
+	if(rss_size > 1) {
+		rss_offset = 1;
+		rss_size--;
+	}
+
 	for (i = 0; i < rss_table_size; i++)
-		lut[i] = i % rss_size;
+		lut[i] = (i % rss_size) + rss_offset;
 }
 
 /**
