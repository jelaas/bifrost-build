--- ipvsadm.sh.orig	Fri Nov 25 10:39:51 2016
+++ ipvsadm.sh	Fri Nov 25 10:43:01 2016
@@ -19,40 +19,22 @@
 
 
 # set the configuration file
-if [ -f "/etc/sysconfig/ipvsadm"  ]; then
-  IPVSADM_CONFIG="/etc/sysconfig/ipvsadm"
-elif [ -f "/etc/ipvsadm.rules"  ]; then
-  IPVSADM_CONFIG="/etc/ipvsadm.rules"
-else
-  IPVSADM_CONFIG="/etc/sysconfig/ipvsadm"
-fi
+IPVSADM_CONFIG="/etc/config.data/ipvsadm.rules"
 
-# Use the funtions provided by Red Hat or use our own
-if [ -f /etc/rc.d/init.d/functions ]
-then
-  . /etc/rc.d/init.d/functions
-else
-  function action {
+function action {
     echo "$1"
     shift
     $@
-  }
-  function success {
+}
+
+function success {
     echo -n "Success"
-  }
-  function failure {
+}
+
+function failure {
     echo -n "Failed"
-  }
-fi
+}
 
-# Check for ipvsadm in both /sbin and /usr/sbin
-# The default install puts it in /sbin, as it is analogos to commands such
-# as route and ipchains that live in /sbin.  Some vendors, most notibly 
-# Red Hat insist on moving it to /usr/sbin
-if [ ! -x /sbin/ipvsadm -a  ! -x /usr/sbin/ipvsadm ]; then
-    exit 0
-fi
-
 case "$1" in
   start)
     # If we don't clear these first, we might be adding to
@@ -76,12 +58,6 @@
 	$0 start
 	;;
 
-  panic)
-	# I'm not sure what panic does but in the case of IPVS	
-        # it makes sense just to clear everything
-        action "Clearing the current IPVS table:" ipvsadm -C
-	;;
-
   status)
 	ipvsadm -L -n
 	;;
@@ -96,7 +72,7 @@
 
   *)
 	echo "Usage: ipvsadm
-	  {start|stop|restart|status|panic|save|reload|reload-force}"
+	  {start|stop|restart|status|save|reload|reload-force}"
 	exit 1
 esac
 
