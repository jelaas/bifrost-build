#!/bin/bash

SRC=m4-1.4.14.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/m4/$SRC
