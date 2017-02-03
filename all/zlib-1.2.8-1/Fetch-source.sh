#!/bin/bash

SRC=zlib-1.2.8.tar.gz
DST=/tmp/$SRC
VDST=/var/spool/src/$SRC

pkg_install curl-7.51.0-1 || exit 2
if ! [ -s "$VDST" ]; then
    pkg_install tarmd-nocomp-1.2-1 || exit 1
    curl -L -k -o $DST https://downloads.sourceforge.net/project/libpng/zlib/1.2.8/$SRC || exit 1
    zcat "$DST" | tarmd 1b6db52e68ab5ab1326cb1909490148d4eec7d5fbd6fcff93a78c47a5c25a15a $VDST
fi
