#!/bin/bash

SRC=patch-2.7.1.tar.gz
DST=/var/spool/src/$SRC
MD5=95dd8d7e41dcbcecdd5cd88ef915378d

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/patch/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
