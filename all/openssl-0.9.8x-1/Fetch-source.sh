#!/bin/bash

SRC=openssl-0.9.8x.tar.gz
DST=/var/spool/src/$SRC

pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || curl -L -k -o $DST http://www.openssl.org/source/$SRC
