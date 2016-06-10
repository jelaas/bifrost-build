#!/bin/bash

SRC=openssl-1.0.1r.tar.gz
DST=/var/spool/src/$SRC

pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC || curl -L -k -o $DST http://www.openssl.org/source/$SRC
