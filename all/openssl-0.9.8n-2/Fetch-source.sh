#!/bin/bash

SRC=openssl-0.9.8n.tar.gz
DST=/var/spool/src/$SRC
MD5=076d8efc3ed93646bd01f04e23c07066

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
