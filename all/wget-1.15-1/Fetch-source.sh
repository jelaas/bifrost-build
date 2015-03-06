#!/bin/bash

SRC=wget-1.15.tar.gz
DST=/var/spool/src/$SRC
MD5=506df41295afc6486662cc47470b4618

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/wget/$SRC \
              || wget -O $DST http://ftp.gnu.org/gnu/wget/$SRC     \
 || ../../wget-finder -O $DST $SRC:$MD5
