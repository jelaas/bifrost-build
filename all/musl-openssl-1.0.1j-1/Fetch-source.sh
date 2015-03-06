#!/bin/bash

SRC=openssl-1.0.1j.tar.gz
DST=/var/spool/src/$SRC
MD5=f7175c9cd3c39bb1907ac8bba9df8ed3

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
