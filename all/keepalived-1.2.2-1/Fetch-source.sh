#!/bin/bash

SRC=keepalived-1.2.2.tar.gz
DST=/var/spool/src/$SRC
MD5=f68327ca142616a8463d2d105db122cd

[ -s "$DST" ] || wget -O $DST http://www.keepalived.org/software/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
