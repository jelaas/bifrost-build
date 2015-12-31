#!/bin/bash

SRC=binutils-2.24.tar.bz2
DST=/var/spool/src/$SRC
MD5=e0f71a7b2ddab0f8612336ac81d9636b

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/binutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
