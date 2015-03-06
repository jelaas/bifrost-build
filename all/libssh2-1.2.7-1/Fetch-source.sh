#!/bin/bash

SRC=libssh2-1.2.7.tar.gz
DST=/var/spool/src/$SRC
MD5=a5d78344886f1282e4008c09bf568076

[ -s "$DST" ] || wget -O $DST http://www.libssh2.org/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
