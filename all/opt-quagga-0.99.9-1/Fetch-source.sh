#!/bin/bash

SRC=quagga-0.99.9.tar.gz
DST=/var/spool/src/$SRC
MD5=4dbdaf91bf6609803819d97d5fccc4c9

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/quagga/$SRC \
              || wget -O $DST http://downloads.sourceforge.net/project/quagga/attic/$SRC \
              || wget -O $DST http://www.quagga.net/download/$SRC \
              || wget -O $DST http://www.quagga.net/download/attic/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
