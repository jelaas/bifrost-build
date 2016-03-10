#!/bin/bash

SRC=findutils-4.4.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/findutils/$SRC
