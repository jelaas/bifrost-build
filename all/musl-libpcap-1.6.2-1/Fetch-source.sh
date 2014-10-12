#!/bin/bash

SRC=libpcap-1.6.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.tcpdump.org/release/$SRC
