#!/bin/bash

SRC=pcre-8.02.tar.bz2
DST=/var/spool/src/$SRC
MD5=27948c1b5f5c1eabc23cba1ebe4c316f

[ -s "$DST" ] || wget -O $DST ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$SRC \
              || wget -O $DST http://kent.dl.sourceforge.net/project/pcre/pcre/8.02/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
