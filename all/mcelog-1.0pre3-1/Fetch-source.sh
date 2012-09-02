#!/bin/bash

SRC=mcelog-1.0pre3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.kernel.org/pub/linux/utils/cpu/mce/$SRC || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC
