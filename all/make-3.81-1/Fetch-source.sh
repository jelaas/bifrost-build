#!/bin/bash

SRC=make-3.81.tar.gz
DST=/var/spool/src/$SRC
MD5=a4e9494ac6dc3f6b0c5ff75c5d52abba

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/make/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
