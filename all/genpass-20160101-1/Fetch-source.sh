#!/bin/bash

GIT=3003b27b6a816eff87af29e14c79b9ae7bb67c55
SRC=genpass-$GIT.tar.gz
DST=/var/spool/src/$SRC
MD5=c18aaaf4eeadc2c6f1090897218c8141

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/chilicuil/genpass/archive/$GIT.tar.gz
test X"$(md5sum "${DST}" | awk '{print $1}')" = X"${MD5}"
