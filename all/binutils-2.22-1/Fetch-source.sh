#!/bin/bash

SRC=binutils-2.22.tar.bz2
DST=/var/spool/src/$SRC
MD5=ee0f10756c84979622b992a4a61ea3f5

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/binutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
