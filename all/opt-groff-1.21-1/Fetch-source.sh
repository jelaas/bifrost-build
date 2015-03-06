#!/bin/bash

SRC=groff-1.21.tar.gz
DST=/var/spool/src/$SRC
MD5=8b8cd29385b97616a0f0d96d0951c5bf

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/groff/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
