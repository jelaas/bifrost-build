#!/bin/bash

SRC=gd-2.0.36RC1.tar.bz2 
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.libgd.org/releases/$SRC || wget -O $DST http://bifrost-repo/$SRC
