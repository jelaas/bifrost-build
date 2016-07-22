#!/bin/bash

SRC=zlib-1.2.8.tar.gz
DST=/var/spool/src/$SRC
MD5=44d667c142d7cda120332623eab69f40

pkg_install tarmd-zlib-1.2-1 || exit 2

[ -s "$DST" ] || tarmd 1b6db52e68ab5ab1326cb1909490148d4eec7d5fbd6fcff93a78c47a5c25a15a $DST \
 /usr/bin/wget -O- http://zlib.net/$SRC || \
 tarmd 1b6db52e68ab5ab1326cb1909490148d4eec7d5fbd6fcff93a78c47a5c25a15a $DST \
 /usr/bin/wget -O- ftp://ftp.simplesystems.org/pub/libpng/png/src/history/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
