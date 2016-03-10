#!/bin/bash

SRC=coreutils-7.6.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/coreutils/$SRC
