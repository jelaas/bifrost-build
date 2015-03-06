#!/bin/bash

SRC=m4-1.4.17.tar.gz
DST=/var/spool/src/$SRC
MD5=a5e9954b1dae036762f7b13673a2cf76

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/m4/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
