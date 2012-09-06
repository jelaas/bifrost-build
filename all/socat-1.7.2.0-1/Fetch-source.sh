#!/bin/bash

SRC=socat-1.7.2.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.dest-unreach.org/socat/download/$SRC
