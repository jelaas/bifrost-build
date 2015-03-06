#!/bin/bash

SRC=libnl-3.2.25.tar.gz
DST=/var/spool/src/$SRC
MD5=03f74d0cd5037cadc8cdfa313bbd195c

[ -s "$DST" ] || wget -O $DST http://www.infradead.org/~tgr/libnl/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
