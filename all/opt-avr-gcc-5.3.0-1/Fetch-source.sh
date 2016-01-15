#!/bin/bash

SRC=gcc-5.3.0.tar.bz2
DST=/var/spool/src/$SRC
[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/gcc/gcc-5.3.0/$SRC
