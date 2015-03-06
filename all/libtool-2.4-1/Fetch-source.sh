#!/bin/bash

SRC=libtool-2.4.tar.gz
DST=/var/spool/src/$SRC
MD5=b32b04148ecdd7344abc6fe8bd1bb021

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/libtool/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
