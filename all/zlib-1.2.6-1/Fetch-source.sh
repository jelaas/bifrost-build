#!/bin/bash

SRC=zlib-1.2.6.tar.bz2
DST=/var/spool/src/$SRC
MD5=dc2cfa0d2313ca77224b4d932b2911e9

[ -s "$DST" ] || wget -O $DST http://www.zlib.net/$SRC \
              || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/zlib/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
