#!/bin/bash

SRC=glib-2.51.0.tar.xz
DST=/var/spool/src/$SRC
MD5=9721b74ba1d1047305d58971556aa2b8

pkg_install wget-1.18-1 || exit 2
[ -s "$DST" ] || wget -O $DST ftp://ftp.gnome.org/pub/GNOME/sources/glib/2.51/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5

