#!/bin/bash

SRC=coreutils-7.6.tar.gz
DST=/var/spool/src/$SRC
MD5=3d82f979229365f880da750642e67cf3

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/coreutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
