#!/bin/bash

SRC=musl-0.9.6.tar.gz
DST=/var/spool/src/$SRC
MD5=23b2f609ef3d7a49da77a3c70dda8bfc

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
