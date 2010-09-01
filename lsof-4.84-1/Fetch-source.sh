#!/bin/bash

SRC=lsof_4.84.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/$SRC
