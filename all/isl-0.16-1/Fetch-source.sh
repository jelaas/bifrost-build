#!/bin/bash

SRC=isl-0.16.tar.bz2
DST=/var/spool/src/$SRC
MD5=29670aaa2af82592f693e99656628943

[ -s "$DST" ] || wget -O $DST http://isl.gforge.inria.fr/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
