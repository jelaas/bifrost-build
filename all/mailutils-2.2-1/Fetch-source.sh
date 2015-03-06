#!/bin/bash

SRC=mailutils-2.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=834d2f616b922856127ecfe6c2de7d1a

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/gnu/mailutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
