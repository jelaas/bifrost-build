#!/bin/bash

SRC=openssl-0.9.8w.tar.gz
DST=/var/spool/src/$SRC
MD5=4ceb7d570e42c094b360cc7b8e848a0b

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
