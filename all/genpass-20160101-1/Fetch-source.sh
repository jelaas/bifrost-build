#!/bin/bash

SRC=2016.01.01.tar.gz
DST=/var/spool/src/genpass-$SRC
MD5=fd61f9eec854f2e7983d0ae9c643915d
pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/chilicuil/genpass/archive/$SRC
test X"$(md5sum "${DST}" | awk '{print $1}')" = X"${MD5}"
