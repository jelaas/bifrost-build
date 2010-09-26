#!/bin/bash

SRC=iproute2-2.6.34.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://devresources.linuxfoundation.org/dev/iproute2/download/$SRC
