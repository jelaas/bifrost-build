#!/bin/bash

SRC=quagga-1.0.20160315.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/quagga/$SRC
