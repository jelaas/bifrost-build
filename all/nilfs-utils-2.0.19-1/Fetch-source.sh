#!/bin/bash

SRC=nilfs-utils-2.0.19.tar.bz2
DST=/var/spool/src/$SRC
MD5=a5cb0146d7444ca907ad67decbeb1d2f

[ -s "$DST" ] || wget -O $DST http://www.nilfs.org/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
