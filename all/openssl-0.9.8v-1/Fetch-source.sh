#!/bin/bash

SRC=openssl-0.9.8v.tar.gz
DST=/var/spool/src/$SRC
MD5=51a40a81b3b7abe8a5c33670bd3da0ce

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
