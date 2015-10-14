#!/bin/bash

SRC=musl-1.1.11.tar.gz
DST=/var/spool/src/$SRC
MD5=48be0777e32f374d387e9cf85e36ec4d

[ -s "$DST" ] || wget -O $DST http://www.musl-libc.org/releases/$SRC    \
              || wget -O $DST http://landley.net/aboriginal/mirror/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
