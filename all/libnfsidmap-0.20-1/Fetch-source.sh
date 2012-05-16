#!/bin/bash

SRC=libnfsidmap-0.20.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap/$SRC
