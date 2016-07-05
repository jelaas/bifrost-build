#!/bin/bash

SRC=zlib-1.2.8.tar.gz
DST=/tmp/$SRC
VDST=/var/spool/src/$SRC

if ! [ -s "$VDST" ]; then
	pkg_install tarmd-nocomp-1.2-1 || exit 1
	wget -O $DST http://zlib.net/$SRC || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/zlib/$SRC
	zcat "$DST" | tarmd 1b6db52e68ab5ab1326cb1909490148d4eec7d5fbd6fcff93a78c47a5c25a15a $VDST
fi
