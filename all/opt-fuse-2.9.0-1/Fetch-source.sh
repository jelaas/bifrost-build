#!/bin/bash

SRC=fuse-2.9.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ignum2.dl.sourceforge.net/project/fuse/fuse-2.X/2.9.0/$SRC || wget -O $DST http://downloads.sourceforge.net/project/fuse/fuse-2.X/2.9.0/$SRC
