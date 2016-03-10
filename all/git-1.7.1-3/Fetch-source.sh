#!/bin/bash

SRC=git-1.7.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.be.debian.org/pub/software/scm/git/$SRC || wget -O $DST ftp://ftp.kernel.org/pub/software/scm/git/$SRC || wget -O $DST http://sunsite.icm.edu.pl/pub/Linux/kernel.org/software/scm/git/$SRC
