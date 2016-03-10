#!/bin/bash

SRC=parted-3.1.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/parted/$SRC
