#!/bin/bash

SRC=tcpdump-4.1.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.tcpdump.org/release/$SRC
