#!/bin/bash

SRC=db-5.2.36.tar.gz
DST=/var/spool/src/$SRC
MD5=88466dd6c13d5d8cddb406be8a1d4d92

[ -s "$DST" ] || wget -O $DST http://download.oracle.com/berkeley-db/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
