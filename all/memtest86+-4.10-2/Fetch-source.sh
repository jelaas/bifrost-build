#!/bin/bash

SRC=memtest86+-4.10.tar.gz
DST=/var/spool/src/$SRC
MD5=2144f21d4489a04149b1891b8d97e8fc

[ -s "$DST" ] || wget -O $DST http://www.memtest.org/download/4.10/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
