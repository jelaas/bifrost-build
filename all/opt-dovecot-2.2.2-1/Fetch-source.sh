#!/bin/bash

SRC=dovecot-2.2.2.tar.gz
DST=/var/spool/src/$SRC
MD5=e6c011b4bbddf19e79205d012723449a

[ -s "$DST" ] || wget -O $DST http://www.dovecot.org/releases/2.2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
