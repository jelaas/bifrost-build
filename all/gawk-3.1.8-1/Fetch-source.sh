#!/bin/bash

SRC=gawk-3.1.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/gawk/$SRC
