#!/bin/bash

SRC=openssl-1.0.1r.tar.gz
DST=/var/spool/src/$SRC
SHA=ddc4ef7cdc9de8596199d692b61c26219c0198cf1f1f9188bbd81a98df315f5c

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/wget -O- http://www.openssl.org/source/$SRC\
 || tarmd $SHA $DST /usr/bin/curl -L -k http://www.openssl.org/source/$SRC
