#!/bin/bash

SRC=cpuburn_1_4_tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pages.sbcglobal.net/redelm/$SRC

