#!/bin/bash

SRC=mm-common-0.9.6.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnome.org/pub/GNOME/sources/mm-common/0.9/$SRC
