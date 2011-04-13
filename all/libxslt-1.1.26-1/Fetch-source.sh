#!/bin/bash

SRC=libxslt-1.1.26.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://xmlsoft.org/libxslt/$SRC
