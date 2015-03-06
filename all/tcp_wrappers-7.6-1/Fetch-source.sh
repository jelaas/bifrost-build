#!/bin/bash

SRC=tcp_wrappers_7.6.tar.gz
DST=/var/spool/src/$SRC
MD5=e6fa25f71226d090f34de3f6b122fb5a

[ -s "$DST" ] || wget -O $DST ftp://ftp.porcupine.org/pub/security/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
