#!/bin/bash

SRC=pptpd-1.4.0.tar.gz
DST=/var/spool/src/$SRC
MD5=36f9f45c6ffa92bc3b6e24ae2d053505

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/poptop/pptpd/pptpd-1.4.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
