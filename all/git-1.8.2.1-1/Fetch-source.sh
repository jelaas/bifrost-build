#!/bin/bash

SRC=git-1.8.2.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://git-core.googlecode.com/files/$SRC
