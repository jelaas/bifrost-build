#!/bin/bash

SRC=libnfnetlink-1.0.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnfnetlink/files/$SRC
