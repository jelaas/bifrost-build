#!/bin/bash

SRC=vlock-1.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://cthulhu.c3d2.de/~toidinamai/vlock/archive/$SRC
