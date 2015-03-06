#!/bin/bash

SRC=squid-3.1.7.tar.bz2
DST=/var/spool/src/$SRC
MD5=83e7aabc1b5bb5b7c83f6dc2f32ca418

[ -s "$DST" ] || wget -O $DST http://www.squid-cache.org/Versions/v3/3.1/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
