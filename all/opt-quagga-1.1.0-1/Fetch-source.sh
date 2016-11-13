#!/bin/bash

SRC=quagga-1.1.0.tar.gz
DST=/var/spool/src/$SRC
SHA=ffd7d7e26eb25b5b2e9208987563f3966499ea57ab3002fa3e8f4c0932d1ac57
MD5=daa303871e07ea5856aae6fd79e89722

pkg_install curl-7.49.1-1 || exit 2
pkg_install tarmd-1.2-1   || exit 2
pkg_install wget-1.15-1   || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://download.savannah.gnu.org/releases/quagga/$SRC \
              || wget -O $DST http://www.quagga.net/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
