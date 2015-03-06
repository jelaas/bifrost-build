#!/bin/bash

SRC=musl-1.1.2.tar.gz
DST=/var/spool/src/$SRC
MD5=a81309e54efdf9c68baf679790fc5678

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
