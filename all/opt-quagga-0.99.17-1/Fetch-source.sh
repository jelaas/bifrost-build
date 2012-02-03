#!/bin/bash

SRC=quagga-0.99.17.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/quagga/attic/$SRC || wget -O $DST http://downloads.sourceforge.net/project/quagga/$SRC|| wget -O $DST http://www.quagga.net/download/$SRC || wget -O $DST http://www.quagga.net/download/attic/$SRC
