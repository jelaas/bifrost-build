#!/bin/bash

SRC=nilfs-utils-2.0.19.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.nilfs.org/download/$SRC
