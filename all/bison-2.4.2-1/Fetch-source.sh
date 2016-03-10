#!/bin/bash

SRC=bison-2.4.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/bison/$SRC
