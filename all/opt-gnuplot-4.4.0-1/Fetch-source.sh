#!/bin/bash

SRC=gnuplot-4.4.0.tar.gz
DST=/var/spool/src/$SRC
MD5=e708665bd512153ad5c35252fe499059

[ -s "$DST" ] || wget -O $DST http://sourceforge.net/projects/gnuplot/files/gnuplot/4.4.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
