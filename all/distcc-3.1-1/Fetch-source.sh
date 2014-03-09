#!/bin/bash

SRC=distcc-3.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://distcc.googlecode.com/files/distcc-3.1.tar.gz
