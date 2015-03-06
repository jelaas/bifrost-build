#!/bin/bash

SRC=quagga-0.99.17.tar.gz
DST=/var/spool/src/$SRC
MD5=37b9022adca04b03863d2d79787e643f

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/quagga/attic/$SRC \
              || wget -O $DST http://downloads.sourceforge.net/project/quagga/$SRC       \
              || wget -O $DST http://www.quagga.net/download/$SRC       \
              || wget -O $DST http://www.quagga.net/download/attic/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
