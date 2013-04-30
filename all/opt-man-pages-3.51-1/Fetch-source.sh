#!/bin/bash

SRC=man-pages-3.51.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://www.kernel.org/pub/linux/docs/man-pages/$SRC
