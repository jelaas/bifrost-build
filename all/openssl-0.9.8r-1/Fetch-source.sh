#!/bin/bash

SRC=openssl-0.9.8r.tar.gz
DST=/var/spool/src/$SRC
MD5=0352932ea863bc02b056cda7c9ac5b79

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
