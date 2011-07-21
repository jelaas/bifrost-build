#!/bin/bash

SRC=libnl-3.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://people.suug.ch/~tgr/libnl/files/$SRC
