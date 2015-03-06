#!/bin/bash

SRC=gmp-4.3.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=dd60683d7057917e34630b4a787932e8

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gmp/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
