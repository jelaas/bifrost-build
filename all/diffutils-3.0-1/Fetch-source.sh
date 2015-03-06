#!/bin/bash

SRC=diffutils-3.0.tar.gz
DST=/var/spool/src/$SRC
MD5=684aaba1baab743a2a90e52162ff07da

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/diffutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
