#!/bin/bash

SRC=musl-1.1.16.tar.gz
DST=/var/spool/src/$SRC
MD5=ac52ccaec6b06ab0f289d37e8436859b

[ -s "$DST" ] || wget -O $DST http://www.musl-libc.org/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
