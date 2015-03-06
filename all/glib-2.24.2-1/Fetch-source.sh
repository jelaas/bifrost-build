#!/bin/bash

SRC=glib-2.24.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=8a6e45d7840460ed84288ebfd75782d4

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnome.org/pub/GNOME/sources/glib/2.24/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
