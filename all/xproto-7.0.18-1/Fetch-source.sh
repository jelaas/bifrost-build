#!/bin/bash

SRC=xproto-7.0.18.tar.bz2
DST=/var/spool/src/$SRC
MD5=6b8a34b274c6fceaffe57c579db826b9

[ -s "$DST" ] || wget -O $DST http://xorg.freedesktop.org/releases/individual/proto/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
