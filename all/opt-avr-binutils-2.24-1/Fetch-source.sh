#!/bin/bash

SRC=binutils-2.24.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/binutils/$SRC
