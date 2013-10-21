--- Configure.orig	2010-05-09 10:56:40.886611141 +0200
+++ Configure	2010-05-09 14:38:00.569613057 +0200
@@ -4091,7 +4091,8 @@
 If this doesn't make any sense to you, just accept the default '$dflt'.
 EOM
 rp='Use the PerlIO abstraction layer?'
-. ./myread
+#. ./myread
+ans=n
 case "$ans" in
 y|Y)
 	val="$define"
@@ -4829,8 +4830,8 @@
 
 EOM
 rp='What is the file extension used for shared libraries?'
-. ./myread
-so="$ans"
+#. ./myread
+so="none"
 
 : Define several unixisms.
 : Hints files or command line option can be used to override them.
@@ -5147,7 +5148,7 @@
 	# as that way the compiler can do the right implementation dependant
 	# thing. (NWC)
 	case "$gccversion" in
-	?*)	set stack-protector -fstack-protector
+	?*)	#set stack-protector -fstack-protector
 		eval $checkccflag
 		;;
 	esac
@@ -5291,7 +5292,7 @@
 esac
 # See note above about -fstack-protector
 case "$ccflags" in
-*-fstack-protector*) 
+*-fstack-protectorX*) 
 	case "$dflt" in
 	*-fstack-protector*) ;; # Don't add it again
 	*) dflt="$dflt -fstack-protector" ;; 
@@ -8086,7 +8087,7 @@
 	esac
 
 	case "$ldflags" in
-	*-fstack-protector*)
+	*-fstack-protectorX*)
 	    case "$dflt" in
 			*-fstack-protector*) ;; # Don't add it again
 			*) dflt="$dflt -fstack-protector" ;; 
@@ -8097,7 +8098,7 @@
 
     rp="Any special flags to pass to $ld to create a dynamically loaded library?"
     . ./myread
-    case "$ans" in
+    case "none" in
     none) lddlflags=' ' ;;
     *) lddlflags="$ans" ;;
     esac
@@ -10217,7 +10218,7 @@
 fi
 : see if struct tm knows about tm_zone
 case "$i_systime$i_time" in
-*$define*)
+*X$define*)
         echo " "
         echo "Checking to see if your struct tm has tm_zone field..." >&4
         set d_tm_tm_zone tm tm_zone $i_systime sys/time.h $i_time time.h
@@ -10229,12 +10230,12 @@
         ;;
 esac
 case "$d_tm_tm_zone" in
-"$define")      echo "Yes, it does."   ;;
+"X$define")      echo "Yes, it does."   ;;
 *)              echo "No, it doesn't." ;;
 esac
 : see if struct tm knows about tm_gmtoff
 case "$i_systime$i_time" in
-*$define*)
+*X$define*)
         echo " "
         echo "Checking to see if your struct tm has tm_gmtoff field..." >&4
         set d_tm_tm_gmtoff tm tm_gmtoff $i_systime sys/time.h $i_time time.h
@@ -10246,7 +10247,7 @@
         ;;
 esac
 case "$d_tm_tm_gmtoff" in
-"$define")      echo "Yes, it does."   ;;
+"X$define")      echo "Yes, it does."   ;;
 *)              echo "No, it doesn't." ;;
 esac
 
