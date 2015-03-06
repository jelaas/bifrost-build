#!/bin/bash

SRC=exim-4.80.tar.bz2
DST=/var/spool/src/$SRC
MD5=de93a242e9e148de28d67056e5c1b34f

[ -s "$DST" ] || wget -O $DST ftp://ftp.exim.org/pub/exim/exim4/$SRC     \
              || wget -O $DST ftp://ftp.exim.org/pub/exim/exim4/old/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
