#!/bin/bash

GIT=834ba1f427e3edc30ff90b43b7dbb1b60ccdd467
SRC=genpass-$GIT.tar.gz
DST=/var/spool/src/$SRC
MD5=d515b212d4414fee792c2b74755ca14a

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/chilicuil/genpass/archive/$GIT.tar.gz
test X"$(md5sum "${DST}" | awk '{print $1}')" = X"${MD5}"
