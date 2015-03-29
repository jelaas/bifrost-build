#!/bin/bash

SRC=openssl-1.0.1m.tar.gz
DST=/var/spool/src/$SRC
MD5=d143d1555d842a069cb7cc34ba745a06

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
