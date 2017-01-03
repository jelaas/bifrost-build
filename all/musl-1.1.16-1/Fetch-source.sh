#!/bin/bash

SRC=musl-1.1.16.tar.gz
DST=/var/spool/src/$SRC

pkg_install tarmd-zlib-1.2-1 || exit 2

[ -s "$DST" ] || tarmd a14e6cb6ad62cb11cedb25aa19b357e7a0f0aba5212b2e255f0320c14e479b13 $DST /usr/bin/wget -O- http://www.musl-libc.org/releases/$SRC
