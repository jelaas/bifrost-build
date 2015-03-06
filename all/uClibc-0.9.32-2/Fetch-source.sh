#!/bin/bash

SRC=uClibc-0.9.32.tar.bz2
DST=/var/spool/src/$SRC
MD5=cfcb6c25d8ebe12817499d8749ee8ae1

[ -s "$DST" ] || wget -O $DST http://uclibc.org/downloads/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
