#!/bin/bash

SRC=zlib-1.2.5.tar.bz2
DST=/var/spool/src/$SRC
MD5=be1e89810e66150f5b0327984d8625a0

[ -s "$DST" ] || wget -O $DST http://www.zlib.net/$SRC \
              || wget -O $DST http://ftp.sunet.se/pub/os/Linux/distributions/bifrost/download/src/$SRC \
              || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/zlib/$SRC         \
 || ../../wget-finder -O $DST $SRC:$MD5
