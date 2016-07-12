#!/bin/bash

SRC=example.tar.gz
DST=/var/spool/src/$SRC
SHA=deadbeef

pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/wget -O- http://source.on.internet/$SRC || wget -O $DST http://bifrost-repo/$SRC

