#!/bin/bash

SRC=fuse-2.8.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ignum2.dl.sourceforge.net/project/fuse/fuse-2.X/2.8.5/fuse-2.8.5.tar.gz

