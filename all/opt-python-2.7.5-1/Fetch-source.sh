#!/bin/bash

SRC=Python-2.7.5.tar.bz2
DST=/var/spool/src/$SRC
MD5=6334b666b7ff2038c761d7b27ba699c1

[ -s "$DST" ] || wget -O $DST http://www.python.org/ftp/python/2.7.5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
