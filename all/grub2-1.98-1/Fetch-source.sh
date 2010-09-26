#!/bin/bash

SRC=grub-1.98.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://alpha.gnu.org/gnu/grub/$SRC
