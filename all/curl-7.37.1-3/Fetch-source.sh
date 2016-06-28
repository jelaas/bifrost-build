#!/bin/bash

SRC=curl-7.37.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=95c627abcf6494f5abe55effe7cd6a57

pkg_install wget-1.15-3 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST http://curl.haxx.se/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
