#!/bin/bash

SRC=lmbench2.tar.gz
DST=/var/spool/src/$SRC
MD5=3a4c0795212a5719cea45f7d7f24f721

[ -s "$DST" ] || wget -O $DST http://www.bitmover.com/lmbench/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
