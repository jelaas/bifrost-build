#!/bin/bash

SRC=libnl-1.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.infradead.org/~tgr/libnl/files/$SRC
