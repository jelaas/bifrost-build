#!/bin/bash

SRC=popt-1.16.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://rpm5.org/files/popt/$SRC
