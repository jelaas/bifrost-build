--- Configure.orig	2010-05-09 10:56:40.886611141 +0200
+++ Configure	2010-05-09 10:57:20.300613136 +0200
@@ -4829,8 +4829,8 @@
 
 EOM
 rp='What is the file extension used for shared libraries?'
-. ./myread
-so="$ans"
+#. ./myread
+so="none"
 
 : Define several unixisms.
 : Hints files or command line option can be used to override them.
