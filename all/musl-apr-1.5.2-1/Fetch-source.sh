#!/bin/bash

SRC=apr-1.5.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=4e9769f3349fe11fc0a5e1b224c236aa

[ -s "$DST" ] || wget -O $DST http://archive.apache.org/dist/apr/$SRC \
              || wget -O $DST http://repository.timesys.com/buildsources/a/apr/apr-1.5.2/$SRC \
              || wget -O $DST http://mirrors.nxnethosting.com/apache/apr/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
