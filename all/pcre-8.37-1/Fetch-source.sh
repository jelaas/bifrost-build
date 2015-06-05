#!/bin/bash

SRC=pcre-8.37.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$SRC || wget -O $DST http://downloads.sourceforge.net/project/pcre/pcre/8.02/$SRC
