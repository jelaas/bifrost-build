#!/bin/bash

SRC=yasm-1.2.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.tortall.net/projects/yasm/releases/$SRC
