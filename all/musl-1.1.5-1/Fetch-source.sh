#!/bin/bash

SRC=musl-1.1.5.tar.gz
DST=/var/spool/src/$SRC
MD5=94f8aa9dab80229fed68991bb9984cc5

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
