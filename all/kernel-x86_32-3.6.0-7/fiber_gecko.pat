--- drivers/net/usb/asix_devices.c.orig	2014-03-17 18:26:57.664875922 +0100
+++ drivers/net/usb/asix_devices.c	2014-03-17 18:27:45.596877058 +0100
@@ -883,6 +883,19 @@
 	.tx_fixup = asix_tx_fixup,
 };
 
+static const struct driver_info lyconsys_fibergecko100_info = {
+	.description = "LyconSys FiberGecko 100 USB 2.0 to Ethernet Adapter",
+	.bind = ax88178_bind,
+	.status = asix_status,
+	.link_reset = ax88178_link_reset,
+	.reset = ax88178_link_reset,
+	.flags =  FLAG_ETHER|FLAG_FRAMING_AX,
+	.rx_fixup =	asix_rx_fixup,
+	.tx_fixup =	asix_tx_fixup,
+	.data = 0x20061201,
+};
+
+
 extern const struct driver_info ax88172a_info;
 
 static const struct usb_device_id	products [] = {
@@ -1022,6 +1035,10 @@
 	/* ASIX 88172a demo board */
 	USB_DEVICE(0x0b95, 0x172a),
 	.driver_info = (unsigned long) &ax88172a_info,
+}, {
+       // LyconSys FiberGecko 100
+        USB_DEVICE (0x1D2A, 0x0801),
+       .driver_info = (unsigned long) &lyconsys_fibergecko100_info,
 },
 	{ },		// END
 };
