#!/bin/bash

SRC=xproto-7.0.18.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://xorg.freedesktop.org/releases/individual/proto/$SRC
