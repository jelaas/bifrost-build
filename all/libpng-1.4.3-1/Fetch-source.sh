#!/bin/bash

SRC=libpng-1.4.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/$SRC || wget -O $DST http://bifrost-repo/$SRC
