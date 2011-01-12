#!/bin/bash

SRC=mfs-1.6.19.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://moosefs.org/tl_files/mfscode/mfs-1.6.19.tar.gz
