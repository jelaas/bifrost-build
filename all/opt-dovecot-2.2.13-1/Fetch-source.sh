#!/bin/bash

SRC=dovecot-2.2.13.tar.gz
DST=/var/spool/src/$SRC
MD5=a3eb1c0b1822c4f2b0fe9247776baa71

[ -s "$DST" ] || wget -O $DST http://www.dovecot.org/releases/2.2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
