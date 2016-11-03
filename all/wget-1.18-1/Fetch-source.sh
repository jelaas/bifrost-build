#!/bin/bash

SRC=wget-1.18.tar.gz
DST=/var/spool/src/$SRC
SHA=692975c1bc2d941eca0fde66ea4606f10afb158c7fd1341f99a0f009c16a76bc

pkg_install curl-7.49.1-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://ftp.gnu.org/gnu/wget/$SRC || tarmd $SHA $DST curl -L -k ftp://sunsite.icm.edu.pl/pub/gnu/wget/$SRC
