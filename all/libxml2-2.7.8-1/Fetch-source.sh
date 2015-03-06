#!/bin/bash

SRC=libxml2-2.7.8.tar.gz
DST=/var/spool/src/$SRC
MD5=8127a65e8c3b08856093099b52599c86

[ -s "$DST" ] || wget -O $DST ftp://xmlsoft.org/libxml2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
