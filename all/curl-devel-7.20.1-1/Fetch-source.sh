#!/bin/bash

SRC=curl-7.20.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=244b16b2a38c70e47130c8494b7371b9

pkg_install wget-1.15-3 || exit 2
[ -s "$DST" ] || wget -O --no-check-certificate $DST http://curl.haxx.se/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
