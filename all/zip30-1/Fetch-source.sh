#!/bin/bash

SRC=zip30.tgz
DST=/var/spool/src/$SRC
MD5=7b74551e63f8ee6aab6fbc86676c0d37

[ -s "$DST" ] || wget -O $DST ftp://ftp.info-zip.org/pub/infozip/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
