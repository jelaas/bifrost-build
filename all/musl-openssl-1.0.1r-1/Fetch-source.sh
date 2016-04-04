#!/bin/bash

SRC=openssl-1.0.1r.tar.gz
DST=/var/spool/src/$SRC
MD5=1abd905e079542ccae948af37e393d28

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
              || wget -O $DST http://slackware.org.uk/slackware/slackware/patches/source/openssl/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
