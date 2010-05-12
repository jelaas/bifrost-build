#!/bin/bash

SRC=grep-2.6.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/grep/$SRC
