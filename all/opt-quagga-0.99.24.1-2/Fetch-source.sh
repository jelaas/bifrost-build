#!/bin/bash

SRC=quagga-0.99.24.1.tar.gz
DST=/var/spool/src/$SRC
MD5=7986bdc2fe6027d4c9216f7f5791e718

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/quagga/$SRC \
     || ../../wget-finder -O $DST $SRC:$MD5
