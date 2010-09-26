#!/bin/bash

SRC=git-1.7.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/software/scm/git/$SRC
