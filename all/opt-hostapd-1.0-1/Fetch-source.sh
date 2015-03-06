#!/bin/bash

SRC=hostapd-1.0.tar.gz
DST=/var/spool/src/$SRC
MD5=236247a7bbd4f60d5fa3e99849d1ffc9

[ -s "$DST" ] || wget -O $DST http://hostap.epitest.fi/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
