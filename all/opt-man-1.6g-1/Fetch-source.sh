#!/bin/bash

SRC=man-1.6g.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://primates.ximian.com/~flucifredi/man/$SRC
