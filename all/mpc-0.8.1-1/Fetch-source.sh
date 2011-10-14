#!/bin/bash

SRC=mpc-0.8.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://gcc.gnu.org/pub/gcc/infrastructure/$SRC
