#!/bin/bash

SRC=quagga-0.99.20.tar.gz
DST=/var/spool/src/$SRC
MD5=64cc29394eb8a4e24649d19dac868f64

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/quagga/$SRC       \
              || wget -O $DST http://downloads.sourceforge.net/project/quagga/attic/$SRC \
              || wget -O $DST http://www.quagga.net/download/$SRC       \
              || wget -O $DST http://www.quagga.net/download/attic/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
