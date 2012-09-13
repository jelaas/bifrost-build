#!/bin/bash

SRC=e2fsprogs-1.42.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.42.5/$SRC
