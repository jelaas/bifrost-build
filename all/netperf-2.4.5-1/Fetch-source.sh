#!/bin/bash

SRC=netperf-2.4.5.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.netperf.org/netperf/$SRC
