#!/bin/bash

SRC=grub-1.99.tar.gz
DST=/var/spool/src/$SRC
MD5=ca9f2a2d571b57fc5c53212d1d22e2b5

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/grub/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
