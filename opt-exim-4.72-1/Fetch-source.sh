#!/bin/bash

SRC=exim-4.72.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.exim.org/pub/exim/exim4/$SRC || wget -O $DST ftp://ftp.exim.org/pub/exim/exim4/old/$SRC
