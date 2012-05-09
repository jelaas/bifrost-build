#!/bin/bash

SRC=snort-2.9.2.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.snort.org/dl/snort-current/$SRC

