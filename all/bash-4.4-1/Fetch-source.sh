#!/bin/bash

SRC=bash-4.4.tar.gz
DST=/var/spool/src/$SRC
SHA=9ec0496ce83b81f320c824457c24791ac06c8b10f29ee05761b1a67ff1637782
MD5=148888a7c95ac23705559b6f477dfe25

pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/wget -O- ftp://sunsite.icm.edu.pl/pub/gnu/bash/$SRC \
    || ../../wget-finder -O $DST $SRC:$MD5
