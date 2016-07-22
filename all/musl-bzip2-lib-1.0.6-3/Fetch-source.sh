#!/bin/bash

SRC=bzip2-1.0.6.tar.gz
DST=/var/spool/src/$SRC
MD5=00b516f4704d4a7cb50a1d97e6e8e15b

pkg_install tarmd-zlib-1.2-1 || exit 2

[ -s "$DST" ] || tarmd 6ffcacd4a3b1fe62f08e8371bb1e433480c183c282533205c4b872ba8396238a $DST \
    /usr/bin/wget -O- http://www.bzip.org/1.0.6/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
