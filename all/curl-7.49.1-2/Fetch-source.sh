#!/bin/bash

SRC=curl-7.49.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=6bb1f7af5b58b30e4e6414b8c1abccab

pkg_install wget-1.15-3 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST http://curl.haxx.se/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
