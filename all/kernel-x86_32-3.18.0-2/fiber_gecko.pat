--- drivers/net/usb/asix_devices.c.orig	Thu Aug 14 09:07:04 2014
+++ drivers/net/usb/asix_devices.c	Thu Aug 14 09:18:28 2014
@@ -946,8 +946,24 @@
 	.data = FLAG_EEPROM_MAC,
 };
 
+static const struct driver_info lyconsys_fibergecko100_info = {
+	.description = "LyconSys FiberGecko 100 USB 2.0 to Ethernet Adapter",
+	.bind = ax88178_bind,
+	.status = asix_status,
+	.link_reset = ax88178_link_reset,
+	.reset = ax88178_link_reset,
+	.flags =  FLAG_ETHER|FLAG_FRAMING_AX,
+	.rx_fixup =	asix_rx_fixup_common,
+	.tx_fixup =	asix_tx_fixup,
+	.data = 0x20061201,
+};
+
 static const struct usb_device_id	products [] = {
 {
+        // LyconSys FiberGecko 100
+        USB_DEVICE (0x1D2A, 0x0801),
+ 	.driver_info = (unsigned long) &lyconsys_fibergecko100_info,
+}, {
 	// Linksys USB200M
 	USB_DEVICE (0x077b, 0x2226),
 	.driver_info =	(unsigned long) &ax8817x_info,
