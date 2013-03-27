#!/bin/bash

SRC=mailutils-2.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/gnu/mailutils/$SRC
