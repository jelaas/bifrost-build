#!/bin/bash

SRC=libvorbis-1.3.3.tar.gz
DST=/var/spool/src/$SRC
MD5=6b1a36f0d72332fae5130688e65efe1f

[ -s "$DST" ] || wget -O $DST http://downloads.xiph.org/releases/vorbis/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
