#!/bin/bash

SRC=openssl-0.9.8q.tar.gz
DST=/var/spool/src/$SRC
MD5=80e67291bec9230f03eefb5cfe858998

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
