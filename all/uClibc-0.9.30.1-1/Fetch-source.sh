#!/bin/bash

SRC=uClibc-0.9.30.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=1a4b84e5536ad8170563ffa88c34679c

[ -s "$DST" ] || wget -O $DST http://uclibc.org/downloads/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
