#!/bin/bash

SRC=binutils-2.20.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=2b9dc8f2b7dbd5ec5992c6e29de0b764

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/binutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
