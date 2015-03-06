#!/bin/bash

SRC=zlib-1.2.8.tar.gz
DST=/var/spool/src/$SRC
MD5=44d667c142d7cda120332623eab69f40

[ -s "$DST" ] || wget -O $DST http://www.zlib.net/$SRC \
              || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
