#!/bin/bash

SRC=hostapd-0.7.3.tar.gz
DST=/var/spool/src/$SRC
MD5=91a7c8d0f090b7104152d3455a84c112

[ -s "$DST" ] || wget -O $DST http://hostap.epitest.fi/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
