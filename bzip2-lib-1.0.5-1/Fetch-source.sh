#!/bin/bash

SRC=bzip2-1.0.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.bzip.org/1.0.5/$SRC

