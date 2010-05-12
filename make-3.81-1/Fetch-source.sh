#!/bin/bash

SRC=make-3.81.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/make/$SRC
