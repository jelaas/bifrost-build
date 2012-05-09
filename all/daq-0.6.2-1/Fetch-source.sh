#!/bin/bash

SRC=daq-0.6.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.snort.org/dl/snort-current/$SRC
