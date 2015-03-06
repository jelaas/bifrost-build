#!/bin/bash

SRC=netperf-2.4.5.tar.bz2
DST=/var/spool/src/$SRC
MD5=5cfaae1d024551161b8eafbd48faedf4

[ -s "$DST" ] || wget -O $DST ftp://ftp.netperf.org/netperf/$SRC         \
              || wget -O $DST ftp://ftp.netperf.org/netperf/archive/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
