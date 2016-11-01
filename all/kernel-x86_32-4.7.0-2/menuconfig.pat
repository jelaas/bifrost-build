--- scripts/kconfig/lxdialog/check-lxdialog.sh.orig	Wed Aug 13 11:14:48 2014
+++ scripts/kconfig/lxdialog/check-lxdialog.sh	Wed Aug 13 11:14:58 2014
@@ -41,6 +41,7 @@
 
 # Check if we can link to ncurses
 check() {
+	exit 0
         $cc -x c - -o $tmp 2>/dev/null <<'EOF'
 #include CURSES_LOC
 main() {}
