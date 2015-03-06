#!/bin/bash

SRC=quagga-0.99.16.tar.gz
DST=/var/spool/src/$SRC
MD5=350fb150be526cdfc4d2b093cb4d69a7

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/quagga/attic/$SRC \
              || wget -O $DST http://www.quagga.net/download/$SRC       \
              || wget -O $DST http://www.quagga.net/download/attic/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
