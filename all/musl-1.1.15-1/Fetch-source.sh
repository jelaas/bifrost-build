#!/bin/bash

SRC=musl-1.1.15.tar.gz
DST=/var/spool/src/$SRC
MD5=9590a9d47ee64f220b3c12f7afb864ca

pkg_install tarmd-zlib-1.2-1 || exit 2

[ -s "$DST" ] || \
    tarmd 66e37834d724b4db5f0967730536295367b96e122b3970acbfdcc708d8a662fe $DST \
    /usr/bin/wget -O- http://www.musl-libc.org/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
