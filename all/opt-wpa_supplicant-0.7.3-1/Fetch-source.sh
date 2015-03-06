#!/bin/bash

SRC=wpa_supplicant-0.7.3.tar.gz
DST=/var/spool/src/$SRC
MD5=f516f191384a9a546e3f5145c08addda

[ -s "$DST" ] || wget -O $DST http://hostap.epitest.fi/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
