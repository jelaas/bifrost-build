#!/bin/bash

SRC=libxslt-1.1.26.tar.gz
DST=/var/spool/src/$SRC
MD5=e61d0364a30146aaa3001296f853b2b9

[ -s "$DST" ] || wget -O $DST ftp://xmlsoft.org/libxslt/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
