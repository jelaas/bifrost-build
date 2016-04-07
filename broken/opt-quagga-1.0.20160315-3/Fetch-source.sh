#!/bin/bash

SRC=quagga-1.0.20160315.tar.gz
DST=/var/spool/src/$SRC
MD5=e73d6e527fb80240f180de420cfe8042

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/quagga/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
