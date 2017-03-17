#!/bin/bash

SRC=musl-1.1.16.tar.gz
DST=/var/spool/src/$SRC
MD5=ac52ccaec6b06ab0f289d37e8436859b

pkg_install tarmd-zlib-1.2-1 || exit 2

[ -s "$DST" ] || \
    tarmd a14e6cb6ad62cb11cedb25aa19b357e7a0f0aba5212b2e255f0320c14e479b13 $DST \
    /usr/bin/wget -O- http://www.musl-libc.org/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
