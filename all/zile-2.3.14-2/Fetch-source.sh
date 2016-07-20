#!/bin/bash

SRC=zile-2.3.14.tar.gz
DST=/var/spool/src/$SRC
SHA=98b7f3157669d7e5da20ce94828085866679977c587592409e9664298cf45de5

pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST wget -O- ftp://sunsite.icm.edu.pl/pub/gnu/zile/$SRC
