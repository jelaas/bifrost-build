#!/bin/bash

SRC=2016.05.04.tar.gz
DST=/var/spool/src/genpass-$SRC
MD5=cb936bc226b09fae4c7c2bc2c04e80b8
pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/chilicuil/genpass/archive/$SRC
test X"$(md5sum "${DST}" | awk '{print $1}')" = X"${MD5}"
