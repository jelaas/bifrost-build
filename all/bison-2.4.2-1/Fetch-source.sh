#!/bin/bash

SRC=bison-2.4.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=63584004613aaef2d3dca19088eb1654

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/bison/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
