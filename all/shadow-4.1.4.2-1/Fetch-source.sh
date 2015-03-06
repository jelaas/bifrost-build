#!/bin/bash

SRC=shadow-4.1.4.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=d593a9cab93c48ee0a6ba056db8c1997

[ -s "$DST" ] || wget -O $DST ftp://pkg-shadow.alioth.debian.org/pub/pkg-shadow/$SRC \
              || wget -O $DST http://pkg-shadow.alioth.debian.org/releases/$SRC      \
 || ../../wget-finder -O $DST $SRC:$MD5
