#!/bin/bash

SRC=libsigc++-2.3.1.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.3/$SRC
