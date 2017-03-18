#!/bin/bash

SRC=m4-1.4.14.tar.gz
DST=/var/spool/src/$SRC
MD5=f0542d58f94c7d0ce0d01224e447be66

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/m4/$SRC \
              || wget -O $DST http://www-uxsup.csx.cam.ac.uk/pub/gnu/m4/$SRC \
              || wget -O $DST http://ftp.acc.umu.se/mirror/gnu.org/gnu/m4/$SRC \
              || wget -O $DST http://ftp.riken.jp/GNU/gnu/m4/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
