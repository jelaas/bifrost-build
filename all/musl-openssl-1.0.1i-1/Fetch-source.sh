#!/bin/bash

SRC=openssl-1.0.1i.tar.gz
DST=/var/spool/src/$SRC
MD5=c8dc151a671b9b92ff3e4c118b174972

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
