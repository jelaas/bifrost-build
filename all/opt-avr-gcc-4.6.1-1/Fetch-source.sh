#!/bin/bash

SRC=gcc-core-4.6.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=0c0e7e35d2215e19de9c97efba507553

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.6.1/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
