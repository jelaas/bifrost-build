#!/bin/bash

SRC=quagga-0.99.20.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.quagga.net/download/$SRC || wget -O $DST http://www.quagga.net/download/attic/$SRC
