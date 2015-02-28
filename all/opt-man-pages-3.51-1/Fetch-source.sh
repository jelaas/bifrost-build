#!/bin/bash

SRC=man-pages-3.51.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.be.debian.org/pub/linux/docs/manpages/$SRC \
              || wget -O $DST http://ftp.ntu.edu.tw/tmp/linux/docs/man-pages/$SRC
