#!/bin/bash

SRC=libogg-1.3.0.tar.gz
DST=/var/spool/src/$SRC
MD5=0a7eb40b86ac050db3a789ab65fe21c2

[ -s "$DST" ] || wget -O $DST http://downloads.xiph.org/releases/ogg/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
