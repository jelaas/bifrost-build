#!/bin/bash

SRC=numactl-2.0.6.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://oss.sgi.com/www/projects/libnuma/download/$SRC
