--- extra/config/lxdialog/check-lxdialog.sh.orig	Fri Sep 16 12:05:12 2011
+++ extra/config/lxdialog/check-lxdialog.sh	Fri Sep 16 12:06:20 2011
@@ -40,6 +40,7 @@
 
 # Check if we can link to ncurses
 check() {
+	exit 0
         $cc -xc - -o $tmp 2>/dev/null <<'EOF'
 #include CURSES_LOC
 main() {}
