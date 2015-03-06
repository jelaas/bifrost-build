#!/bin/bash

SRC=quagga-0.99.21.tar.gz
DST=/var/spool/src/$SRC
MD5=95944647f0a0485b0fbd6843d89af476

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/quagga/$SRC       \
              || wget -O $DST http://downloads.sourceforge.net/project/quagga/attic/$SRC \
              || wget -O $DST http://www.quagga.net/download/$SRC       \
              || wget -O $DST http://www.quagga.net/download/attic/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
