#!/bin/bash

SRC=automake-1.13.1.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/gnu/automake/$SRC
