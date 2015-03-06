#!/bin/bash

SRC=openssl-1.0.1h.tar.gz
DST=/var/spool/src/$SRC
MD5=8d6d684a9430d5cc98a62a5d8fbda8cf

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
