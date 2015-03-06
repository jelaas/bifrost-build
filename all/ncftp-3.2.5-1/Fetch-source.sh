#!/bin/bash

SRC=ncftp-3.2.5-src.tar.bz2
DST=/var/spool/src/$SRC
MD5=b05c7a6d5269c04891f02f43d4312b30

[ -s "$DST" ] || wget -O $DST ftp://ftp.ncftp.com/ncftp/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
