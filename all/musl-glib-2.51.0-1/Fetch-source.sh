#!/bin/bash

SRC=glib-2.51.0.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnome.org/pub/GNOME/sources/glib/2.51/$SRC

