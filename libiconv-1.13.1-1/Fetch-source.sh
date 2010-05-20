#!/bin/bash

SRC=libiconv-1.13.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/pub/gnu/libiconv/$SRC
