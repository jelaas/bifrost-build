#!/bin/bash

SRC=libevent-2.0.22-stable.tar.gz
DST=/var/spool/src/libevent-2.0.22.tar.gz
MD5=c4c56f986aa985677ca1db89630a2e11

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/$SRC \
              || wget -O $DST http://down1.ixiazai.net/lnmp/$SRC   \
              || wget -O $DST http://crux.ster.zone/distfiles/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
