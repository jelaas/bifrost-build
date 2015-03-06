#!/bin/bash

SRC=expat-2.0.1.tar.gz
DST=/var/spool/src/$SRC
MD5=ee8b492592568805593f81f8cdf2a04c

[ -s "$DST" ] || wget -O $DST http://heanet.dl.sourceforge.net/project/expat/expat/2.0.1/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
