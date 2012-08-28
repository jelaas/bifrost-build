#!/bin/bash

SRC=zlib-1.2.5.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.zlib.net/$SRC || http://ftp.sunet.se/pub/os/Linux/distributions/bifrost/download/src/$SRC || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/$SRC
