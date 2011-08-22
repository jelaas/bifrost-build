#!/bin/bash

SRC=jpegsrc.v8c.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.ijg.org/files/$SRC
