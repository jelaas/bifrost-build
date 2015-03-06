#!/bin/bash

SRC=openssl-1.0.1g.tar.gz
DST=/var/spool/src/$SRC
MD5=de62b43dfcd858e66a74bee1c834e959

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
