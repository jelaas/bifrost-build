#!/bin/bash

SRC=socat-1.7.2.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.dest-unreach.org/socat/download/$SRC
