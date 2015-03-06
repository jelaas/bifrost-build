#!/bin/bash

SRC=lzo-2.03.tar.gz
DST=/var/spool/src/$SRC
MD5=0c3d078c2e8ea5a88971089a2f02a726

[ -s "$DST" ] || wget -O $DST http://www.oberhumer.com/opensource/lzo/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
