#!/bin/bash

SRC=musl-1.1.14.tar.gz
DST=/var/spool/src/$SRC

pkg_install tarmd-zlib-1.2-1 || exit 2

[ -s "$DST" ] || tarmd 2b45daa03169d684718b6b72381c2b786501540861303d5fb415fc40a6a749c8 $DST /usr/bin/wget -O- http://www.musl-libc.org/releases/$SRC
