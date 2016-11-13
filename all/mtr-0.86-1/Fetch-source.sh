#!/bin/bash

SRC=mtr-0.87.tar.gz
DST=/var/spool/src/$SRC
SHA=70c537f2979c2c96920897733b5e498770685ad2ff329b9db8d7233fbd754108
MD5=fbc82d6784c4292ff79651e21ecd649f

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1   || exit 2
pkg_install wget-1.15-1   || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k ftp://ftp.bitwizard.nl/mtr/$SRC \
              || ../../wget-finder -O $DST $SRC:$MD5
