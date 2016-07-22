#!/bin/bash

SRC=xz-5.2.2.tar.gz
DST=/var/spool/src/$SRC
MD5=7cf6a8544a7dae8e8106fdf7addfa28c

pkg_install tarmd-zlib-1.2-1 || exit 2

[ -s "$DST" ] || tarmd bc98a4257c19bffe7df9ad3101b72d1ade9df10418adf0a4139fb151cb3a0203 $DST \
    /usr/bin/wget -O- http://tukaani.org/xz/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
