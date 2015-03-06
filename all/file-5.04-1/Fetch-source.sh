#!/bin/bash

SRC=file-5.04.tar.gz
DST=/var/spool/src/$SRC
MD5=accade81ff1cc774904b47c72c8aeea0

[ -s "$DST" ] || wget -O $DST ftp://ftp.astron.com/pub/file/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
