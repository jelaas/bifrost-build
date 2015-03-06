#!/bin/bash

SRC=wpa_supplicant-1.0.tar.gz
DST=/var/spool/src/$SRC
MD5=8650f6aa23646ef634402552d0669640

[ -s "$DST" ] || wget -O $DST http://hostap.epitest.fi/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
