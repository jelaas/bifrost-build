#!/bin/bash

SRC=openssl-0.9.8n.tar.gz
DST=/var/spool/src/$SRC

pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC || curl -L -k -o $DST http://www.openssl.org/source/$SRC
