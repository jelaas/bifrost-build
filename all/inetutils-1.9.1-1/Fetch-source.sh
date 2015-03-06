#!/bin/bash

SRC=inetutils-1.9.1.tar.gz
DST=/var/spool/src/$SRC
MD5=944f7196a2b3dba2d400e9088576000c

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/gnu/inetutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
