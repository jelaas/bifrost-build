#!/bin/bash

SRC=curl-7.48.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=d42e0fc34a5cace5739631cc040974fe

pkg_install wget-1.15-3 || exit 1

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://curl.haxx.se/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
