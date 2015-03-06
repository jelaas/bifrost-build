#!/bin/bash

SRC=libnl-1.1.tar.gz
DST=/var/spool/src/$SRC
MD5=ae970ccd9144e132b68664f98e7ceeb1

[ -s "$DST" ] || wget -O $DST http://people.suug.ch/~tgr/libnl/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
