#!/bin/bash

SRC=e2fsprogs-1.41.11.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://surfnet.dl.sourceforge.net/project/e2fsprogs/e2fsprogs/1.41.11/$SRC
