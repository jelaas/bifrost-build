#!/bin/bash

SRC=imake-1.0.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=ff553c4646edcc9e76b7308991ad421a

[ -s "$DST" ] || wget -O $DST http://xorg.freedesktop.org/releases/individual/util/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
