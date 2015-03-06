#!/bin/bash

SRC=gzip-1.4.tar.gz
DST=/var/spool/src/$SRC
MD5=e381b8506210c794278f5527cba0e765

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gzip/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
