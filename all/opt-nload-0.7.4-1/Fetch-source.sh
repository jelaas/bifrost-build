#!/bin/bash

SRC=nload-0.7.4.tar.gz
DST=/var/spool/src/$SRC
MD5=3c733c528f244ca5a4f76bf185729c39

[ -s "$DST" ] || wget -O $DST http://www.roland-riegel.de/nload/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
