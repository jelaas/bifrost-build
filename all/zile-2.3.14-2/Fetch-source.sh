#!/bin/bash

SRC=zile-2.3.14.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sunsite.icm.edu.pl/pub/gnu/zile/$SRC
