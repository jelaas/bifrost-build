#!/bin/bash

SRC=automake-1.10.tar.bz2
DST=/var/spool/src/$SRC
MD5=0e2e0f757f9e1e89b66033905860fded

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/automake/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
