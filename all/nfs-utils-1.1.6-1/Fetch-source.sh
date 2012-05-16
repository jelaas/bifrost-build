#!/bin/bash

SRC=nfs-utils-1.1.6.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://freefr.dl.sourceforge.net/project/nfs/nfs-utils/1.1.6/$SRC
