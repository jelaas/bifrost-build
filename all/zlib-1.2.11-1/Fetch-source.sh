#!/bin/bash

SRC=zlib-1.2.11.tar.gz
DST=/tmp/$SRC
VDST=/var/spool/src/$SRC
MD5=1c9f62f0778697a09d36121ead88e08e

pkg_install curl-7.51.0-1 || exit 2
if ! [ -s "$VDST" ]; then
    pkg_install tarmd-nocomp-1.2-1 || exit 1
    wget -O $DST http://zlib.net/$SRC || \
        wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/zlib/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
    zcat "$DST" | tarmd 4cba64de1adb4b79b8eb2ddb05382fa787031bd61899138b8d779bfc61931a31 $VDST
fi
