#!/bin/bash

SRC=ncurses-5.7.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/ncurses/$SRC
