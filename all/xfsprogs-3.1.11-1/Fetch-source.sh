#!/bin/bash

SRC=xfsprogs-3.1.11.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://oss.sgi.com/projects/xfs/cmd_tars/$SRC
