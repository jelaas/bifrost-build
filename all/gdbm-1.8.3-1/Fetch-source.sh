#!/bin/bash

SRC=gdbm-1.8.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/gdbm/$SRC
