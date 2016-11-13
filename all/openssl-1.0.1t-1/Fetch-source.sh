#!/bin/bash

SRC=openssl-1.0.1t.tar.gz
DST=/var/spool/src/$SRC
SHA=3640727bf98e70de068d3783a066b8684d620243bb45451f46a63e07d1f60432
MD5=51a40a81b3b7abe8a5c33670bd3da0ce

pkg_install tarmd-1.2-1 || exit 2
pkg_install wget-1.15-3 || exit 2

[ -s "$DST" ] || tarmd $SHA $DST wget --no-check-certificate -O- http://www.openssl.org/source/$SRC \
    || ../../wget-finder -O $DST $SRC:$MD5
