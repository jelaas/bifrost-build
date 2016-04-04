#!/bin/bash

SRC=musl-1.1.14.tar.gz
DST=/var/spool/src/$SRC
MD5=d529ce4a2f7f79d8c3fd4b8329417b57

[ -s "$DST" ] || wget -O $DST http://www.musl-libc.org/releases/$SRC \
              || wget -O $DST https://foss.aueb.gr/mirrors/linux/musl-libc/$SRC \
              || wget -O $DST http://landley.net/aboriginal/mirror/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
