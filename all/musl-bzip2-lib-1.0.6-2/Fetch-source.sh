#!/bin/bash

SRC=bzip2-1.0.6.tar.gz
DST=/var/spool/src/$SRC
MD5=00b516f4704d4a7cb50a1d97e6e8e15b

[ -s "$DST" ] || wget -O $DST http://www.bzip.org/1.0.6/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
