#!/bin/bash

SRC=pth-2.0.7.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/gnu/pth/pth-2.0.7.tar.gz
