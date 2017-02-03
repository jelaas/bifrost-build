#!/bin/bash

SRC=zlib-1.2.11.tar.gz
DST=/tmp/$SRC
VDST=/var/spool/src/$SRC

pkg_install curl-7.51.0-1 || exit 2
if ! [ -s "$VDST" ]; then
    pkg_install tarmd-nocomp-1.2-1 || exit 1
    curl -L -k -o $DST https://downloads.sourceforge.net/project/libpng/zlib/1.2.11/$SRC || exit 1
    zcat "$DST" | tarmd 4cba64de1adb4b79b8eb2ddb05382fa787031bd61899138b8d779bfc61931a31 $VDST
fi
