#!/bin/bash

SRC=yasm-1.2.0.tar.gz
DST=/var/spool/src/$SRC
MD5=4cfc0686cf5350dd1305c4d905eb55a6

[ -s "$DST" ] || wget -O $DST http://www.tortall.net/projects/yasm/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
