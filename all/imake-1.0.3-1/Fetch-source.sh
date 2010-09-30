#!/bin/bash

SRC=imake-1.0.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://xorg.freedesktop.org/releases/individual/util/$SRC
