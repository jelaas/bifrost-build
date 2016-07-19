#!/bin/bash

SRC=tar-1.23.tar.bz2
DST=/var/spool/src/$SRC
SHA=ddac082c9daad82a2e4d9c7d9038828c886fb8c341d91d1d886024c2e8baf457

pkg_install tarmd-1.2-1 || exit 2

[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/wget -O- ftp://sunsite.icm.edu.pl/pub/gnu/tar/$SRC
