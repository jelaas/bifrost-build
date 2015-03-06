#!/bin/bash

SRC=musl-1.1.3.tar.gz
DST=/var/spool/src/$SRC
MD5=1628bd4c86b14b90447e1dcf8421aed7

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
