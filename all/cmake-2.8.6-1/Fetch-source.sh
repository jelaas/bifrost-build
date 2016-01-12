#!/bin/bash

SRC=cmake-2.8.6.tar.gz
DST=/var/spool/src/$SRC
MD5=2147da452fd9212bb9b4542a9eee9d5b

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST http://www.cmake.org/files/v2.8/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
