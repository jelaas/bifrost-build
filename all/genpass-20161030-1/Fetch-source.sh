#!/bin/bash

SRC=2016.10.30.tar.gz
DST=/var/spool/src/genpass-$SRC
MD5=363a53dcd7e8e8ca54addd01b8f3a457

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/chilicuil/genpass/archive/$SRC
test X"$(md5sum "${DST}" | awk '{print $1}')" = X"${MD5}"
