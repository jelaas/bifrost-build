#!/bin/bash

SRC=libtirpc-1.0.1.tar.bz2
DST=/var/spool/src/$SRC
SHA=3047bb7e838ba30aa9a2f6ead52253688c331b3c41c324caf0ddb1bd5d762f02
MD5=36ce1c0ff80863bb0839d54aa0b94014

pkg_install wget-1.18-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/libtirpc/libtirpc/1.0.1/$SRC \
    || ../../wget-finder -O $DST $SRC:$MD5
