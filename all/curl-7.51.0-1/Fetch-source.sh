#!/bin/bash

SRC=curl-7.51.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=09a7c5769a7eae676d5e2c86d51f167e

pkg_install wget-1.15-3 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST https://curl.haxx.se/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
