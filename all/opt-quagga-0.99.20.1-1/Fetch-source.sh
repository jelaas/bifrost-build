#!/bin/bash

SRC=quagga-0.99.20.1.tar.gz
DST=/var/spool/src/$SRC
MD5=270ddd464407f8ce6fa8ada8bc1abbd7

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/quagga/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
