#!/bin/bash

SRC=openssl-0.9.8t.tar.gz
DST=/var/spool/src/$SRC
MD5=f5dabb7ffb068eecf245f1b2151df100

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
