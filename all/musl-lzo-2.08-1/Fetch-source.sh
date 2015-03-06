#!/bin/bash

SRC=lzo-2.08.tar.gz
DST=/var/spool/src/$SRC
MD5=fcec64c26a0f4f4901468f360029678f

[ -s "$DST" ] || wget -O $DST http://www.oberhumer.com/opensource/lzo/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
