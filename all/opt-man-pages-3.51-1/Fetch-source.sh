#!/bin/bash

SRC=man-pages-3.51.tar.gz
DST=/var/spool/src/$SRC
MD5=bed1627674356ec85492c5e94619b23d

[ -s "$DST" ] || wget -O $DST http://ftp.be.debian.org/pub/linux/docs/manpages/$SRC \
              || wget -O $DST http://ftp.ntu.edu.tw/tmp/linux/docs/man-pages/$SRC   \
 || ../../wget-finder -O $DST $SRC:$MD5
