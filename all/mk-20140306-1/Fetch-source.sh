#!/bin/bash

SRC=plan9port-20140306.tgz
DST=/var/spool/src/$SRC
SHA512=a0671163940186fd3d8cf37f06824f0d5a4b9734c1e70eb3174cd7f6b9a1ae769cf78e067dcf4e963192a26a2420b4bb1ce79ed788314ed1783c3bd793fe2aef

if [ ! -s "$DST" ]; then
    pkg_install openssl-0.9.8n-2 || exit 2
    #its disturbing the amount of corrupted plan9port tars the Openbsd mirrored
    wget -O $DST http://ftp.cc.uoc.gr/mirrors/OpenBSD/distfiles/plan9port/$SRC || \
    ../../wget-finder -O $DST $SRC:$SHA512 || exit 1
fi
