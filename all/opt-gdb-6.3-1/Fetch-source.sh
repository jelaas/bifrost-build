#!/bin/bash

SRC=gdb-6.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=05b928f41fa5b482e49ca2c24762a0ae

[ -s "$DST" ] || wget -O $DST http://ftp.lanet.lv/ftp/GNU/gdb/$SRC \
              || wget -O $DST http://ftp.yz.yamagata-u.ac.jp/pub/GNU/gdb/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/gdb/gdb-6.3.tar.bz2/05b928f41fa5b482e49ca2c24762a0ae/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
