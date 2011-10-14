#!/bin/bash

SRC=mpfr-2.4.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.mpfr.org/mpfr-2.4.2/$SRC
