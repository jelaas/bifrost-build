#!/bin/bash

SRC=libnl-3.2.13.tar.gz
DST=/var/spool/src/$SRC
MD5=5f1c6fcf4f56aafbc4bf13ec6ef80cbf

[ -s "$DST" ] || wget -O $DST http://people.suug.ch/~tgr/libnl/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
