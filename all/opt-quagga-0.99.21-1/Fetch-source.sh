#!/bin/bash

SRC=quagga-0.99.21.tar.gz
DST=/var/spool/src/$SRC
MD5=99840adbe57047c90dfba6b6ed9aec7f

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/quagga/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
