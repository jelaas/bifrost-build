#!/bin/bash

SRC=xz-5.0.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=8d900b742b94fa9e708ca4f5a4b29003

[ -s "$DST" ] || wget -O $DST http://tukaani.org/xz/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
