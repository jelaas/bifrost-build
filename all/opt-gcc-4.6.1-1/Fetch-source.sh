#!/bin/bash

SRC=gcc-core-4.6.1.tar.bz2
DST=/var/spool/src/$SRC
[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.6.1/$SRC

SRC=gcc-g++-4.6.1.tar.bz2
DST=/var/spool/src/$SRC
[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.6.1/$SRC
