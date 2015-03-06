#!/bin/bash

SRC=automake-1.11.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=c2972c4d9b3e29c03d5f2af86249876f

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/automake/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
