--- dhcpcd-hooks/20-resolv.conf.orig	Tue Mar 19 18:54:46 2013
+++ dhcpcd-hooks/20-resolv.conf	Tue Mar 19 18:56:15 2013
@@ -10,7 +10,7 @@
 
 build_resolv_conf()
 {
-	local cf="/etc/resolv.conf.${interface}"
+	local cf="/tmp/resolv.conf.${interface}.$$"
 	local interfaces= header= search= srvs= servers= x=
 
 	# Build a list of interfaces
@@ -51,7 +51,8 @@
 	else
 		echo "# /etc/resolv.conf.tail can replace this line" >> "${cf}"
 	fi
-	mv -f "${cf}" /etc/resolv.conf
+	cat "${cf}" > /etc/resolv.conf
+	rm -f "${cf}"
 }
 
 add_resolv_conf()
