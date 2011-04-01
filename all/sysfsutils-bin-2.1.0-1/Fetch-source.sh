#!/bin/bash

SRC=sysfsutils-2.1.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ignum.dl.sourceforge.net/project/linux-diag/sysfsutils/2.1.0/$SRC
