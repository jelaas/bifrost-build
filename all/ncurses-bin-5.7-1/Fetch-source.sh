#!/bin/bash

SRC=ncurses-5.7.tar.gz
DST=/var/spool/src/$SRC
SHA=f9287ad5839bbd398f5f185d28b4e6041ced2758ed5b03a616bb3365e3dc5db8

pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST wget -O- ftp://sunsite.icm.edu.pl/pub/gnu/ncurses/$SRC
