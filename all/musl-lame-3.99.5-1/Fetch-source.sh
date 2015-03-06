#!/bin/bash

SRC=lame-3.99.5.tar.gz
DST=/var/spool/src/$SRC
MD5=84835b313d4a8b68f5349816d33e07ce

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/lame/lame/3.99/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
