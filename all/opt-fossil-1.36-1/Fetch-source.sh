#!/bin/bash

SRC=fossil-src-1.36.tar.gz
DST=/var/spool/src/$SRC
SHA=1b0c578382ecb579389b0ff590cc177b83a6ce85c607666293bfea8ebb67046d

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://fossil-scm.org/index.html/uv/download/$SRC
