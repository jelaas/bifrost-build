--- scripts/kconfig/lxdialog/check-lxdialog.sh~	Mon Feb 14 12:52:22 2011
+++ scripts/kconfig/lxdialog/check-lxdialog.sh	Tue Feb 15 21:17:48 2011
@@ -38,6 +38,7 @@
 
 # Check if we can link to ncurses
 check() {
+	exit 0
         $cc -xc - -o $tmp 2>/dev/null <<'EOF'
 #include CURSES_LOC
 main() {}
