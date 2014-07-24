#!/bin/bash

SRC=zlib-1.2.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.zlib.net/$SRC || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/$SRC
