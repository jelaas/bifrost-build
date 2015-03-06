#!/bin/bash

SRC=libiconv-1.13.1.tar.gz
DST=/var/spool/src/$SRC
MD5=7ab33ebd26687c744a37264a330bbe9a

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/pub/gnu/libiconv/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
