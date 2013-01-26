#!/bin/bash

SRC=Python-2.7.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.python.org/ftp/python/2.7/$SRC
