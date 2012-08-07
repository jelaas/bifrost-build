#!/bin/bash

SRC=bind-9.9.1-P2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.isc.org/isc/bind9/9.9.1-P2/$SRC
