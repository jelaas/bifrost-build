#!/bin/bash

SRC=openssl-1.0.1p.tar.gz
DST=/var/spool/src/$SRC
SHA=4572bfdd47bd214a12232f0cadba9e83be14afaea5bf3b0abfe85970b4360255

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/curl -L -k http://www.openssl.org/source/$SRC
