#!/bin/bash

SRC=libssh2-1.3.0.tar.gz
DST=/var/spool/src/$SRC
MD5=6425331899ccf1015f1ed79448cb4709

[ -s "$DST" ] || wget -O $DST http://www.libssh2.org/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
