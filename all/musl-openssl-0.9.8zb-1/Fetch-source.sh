#!/bin/bash

SRC=openssl-0.9.8zb.tar.gz
DST=/var/spool/src/$SRC
MD5=65c5f42734f8ecd58990b12a9afa6453

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
