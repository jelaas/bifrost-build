#!/bin/bash

SRC=libid3tag-0.15.1b.tar.gz
DST=/var/spool/src/$SRC
MD5=e5808ad997ba32c498803822078748c3

[ -s "$DST" ] || wget -O $DST ftp://ftp.mars.org/pub/mpeg/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
