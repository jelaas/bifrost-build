#!/bin/bash

SRC=libdnet-1.12.tgz
DST=/var/spool/src/$SRC
MD5=9253ef6de1b5e28e9c9a62b882e44cc9

[ -s "$DST" ] || wget -O $DST http://libdnet.googlecode.com/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
