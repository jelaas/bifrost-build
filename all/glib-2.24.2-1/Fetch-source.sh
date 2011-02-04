#!/bin/bash

SRC=glib-2.24.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnome.org/pub/GNOME/sources/glib/2.24/$SRC

