#!/bin/bash

SRC=open-vm-tools-10.0.5-3227872.tar.gz
DST=/var/spool/src/$SRC
SHA=c238b1e143680d0ae5a57e8afead06acee44223f4b0407fe0019f7606dd8ef54
MD5=734eccf6e9e007cb37dc4eb3ed6707b5

pkg_install wget-1.18-1   || exit 2
pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1   || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/open-vm-tools/open-vm-tools/stable-10.0.x/$SRC \
    || ../../wget-finder -O $DST $SRC:$MD5
