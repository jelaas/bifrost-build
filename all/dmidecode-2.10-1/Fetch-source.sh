#!/bin/bash

SRC=dmidecode-2.10.tar.bz2
DST=/var/spool/src/$SRC
MD5=3c9c4d55a40b78600f3b43bfa64616f9

[ -s "$DST" ] || wget -O $DST http://nongnu.uib.no/dmidecode/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
