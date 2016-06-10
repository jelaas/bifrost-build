#!/bin/bash

SRC=curl-7.20.1.tar.bz2
DST=/var/spool/src/$SRC

pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || wget -O $DST http://curl.haxx.se/download/$SRC || curl -L -k -o $DST http://curl.haxx.se/download/$SRC
