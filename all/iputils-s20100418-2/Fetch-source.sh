#!/bin/bash

SRC=iputils-s20100418.tar.bz2
DST=/var/spool/src/$SRC
MD5=df6b0062118cdc5c62e3c810f831e976

[ -s "$DST" ] || wget -O $DST http://www.skbuff.net/iputils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
