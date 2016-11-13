#!/bin/bash

SRC=dovecot-2.2.2.tar.gz
DST=/var/spool/src/$SRC
MD5=e6c011b4bbddf19e79205d012723449a

pkg_install wget-1.15-1 || exit 2

[ -s "$DST" ] || wget -O $DST http://www.dovecot.org/releases/2.2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
