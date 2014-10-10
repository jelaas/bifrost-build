#!/bin/bash

SRC=libnl-3.2.25.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.infradead.org/~tgr/libnl/files/$SRC
