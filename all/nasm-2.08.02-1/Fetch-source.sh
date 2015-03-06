#!/bin/bash

SRC=nasm-2.08.02.tar.bz2
DST=/var/spool/src/$SRC
MD5=2b0dfe9266491c14c4025f57c9cfd0f1

[ -s "$DST" ] || wget -O $DST http://www.nasm.us/pub/nasm/releasebuilds/2.08.02/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
