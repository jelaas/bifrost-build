#!/bin/bash

SRC=zlib-1.2.5.tar.bz2
DST=/tmp/$SRC
VDST=/var/spool/src/$SRC

pkg_install curl-7.51.0-1 || exit 2
if ! [ -s "$VDST" ]; then
    pkg_install tarmd-nocomp-1.2-1 || exit 1
    curl -L -k -o $DST https://downloads.sourceforge.net/project/libpng/zlib/1.2.5/$SRC || exit 1
    bzcat "$DST" | tarmd 66cc047df8521b78c4385ca076acfe49f36b91349438037a84dc1be772bb6521 $VDST
fi
