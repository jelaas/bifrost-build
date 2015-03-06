#!/bin/bash

SRC=sqlite-autoconf-3071602.tar.gz
DST=/var/spool/src/$SRC
MD5=ce7d2bc0d9b8dd18995b888c6b0b220f

[ -s "$DST" ] || wget -O $DST http://www.sqlite.org/2013/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
