#!/bin/bash

SRC=grub-1.98.tar.gz
DST=/var/spool/src/$SRC
MD5=c0bcf60e524739bb64e3a2d4e3732a59

[ -s "$DST" ] || wget -O $DST ftp://alpha.gnu.org/gnu/grub/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
