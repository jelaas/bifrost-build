#!/bin/bash

SRC=ntp-4.2.6p2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/$SRC
