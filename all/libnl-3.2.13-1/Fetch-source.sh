#!/bin/bash

SRC=libnl-3.2.13.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://people.suug.ch/~tgr/libnl/files/$SRC
