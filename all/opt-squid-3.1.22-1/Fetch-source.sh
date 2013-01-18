#!/bin/bash

SRC=squid-3.1.22.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.squid-cache.org/Versions/v3/3.1/$SRC
