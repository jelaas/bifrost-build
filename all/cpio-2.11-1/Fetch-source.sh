#!/bin/bash

SRC=cpio-2.11.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/cpio/$SRC
