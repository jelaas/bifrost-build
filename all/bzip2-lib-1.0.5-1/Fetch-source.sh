#!/bin/bash

SRC=bzip2-1.0.5.tar.gz
DST=/var/spool/src/$SRC
MD5=3c15a0c8d1d3ee1c46a1634d00617b1a

[ -s "$DST" ] || wget -O $DST http://www.bzip.org/1.0.5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
