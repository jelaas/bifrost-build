#!/bin/bash

SRC=mpfr-2.4.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=89e59fe665e2b3ad44a6789f40b059a0

[ -s "$DST" ] || wget -O $DST http://www.mpfr.org/mpfr-2.4.2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
