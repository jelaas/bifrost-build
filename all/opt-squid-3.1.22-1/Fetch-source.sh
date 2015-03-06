#!/bin/bash

SRC=squid-3.1.22.tar.bz2
DST=/var/spool/src/$SRC
MD5=a25ce5937875990c950cc8cd1b120a5e

[ -s "$DST" ] || wget -O $DST http://www.squid-cache.org/Versions/v3/3.1/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
