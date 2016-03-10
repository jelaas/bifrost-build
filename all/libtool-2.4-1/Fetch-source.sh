#!/bin/bash

SRC=libtool-2.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/libtool/$SRC
