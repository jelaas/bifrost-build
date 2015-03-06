#!/bin/bash

SRC=quagga-0.99.23.1.tar.gz
DST=/var/spool/src/$SRC
MD5=f9d9c63529c55d646a4cbe6513b37953

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/quagga/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
