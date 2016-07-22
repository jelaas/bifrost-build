#!/bin/bash

SRC=bash-4.1.tar.gz
DST=/var/spool/src/$SRC
SHA=3b880dc7eee5b36382583e430fdbc7118f3506c24625b6419df9b3d2242f99f0
MD5=9800d8724815fd84994d9be65ab5e7b8

pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/wget -O- ftp://sunsite.icm.edu.pl/pub/gnu/bash/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
