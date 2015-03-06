#!/bin/bash

SRC=openssl-0.9.8p.tar.gz
DST=/var/spool/src/$SRC
MD5=7f24047f70364c9eabc94899e356ce39

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
