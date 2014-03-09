#!/bin/bash

SRC=git-1.8.2.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/software/scm/git/$SRC || wget -O $DST http://ftp.sunet.se/pub/Linux/kernel.org/software/scm/git/$SRC
