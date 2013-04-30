#!/bin/bash

SRC=libid3tag-0.15.1b.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.mars.org/pub/mpeg/$SRC
