#!/bin/bash

SRC=shadow-4.1.4.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://pkg-shadow.alioth.debian.org/pub/pkg-shadow/$SRC
