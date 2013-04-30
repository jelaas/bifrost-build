#!/bin/bash
SRC=jpegsrc.v9.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.ijg.org/files/$SRC

