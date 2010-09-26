#!/bin/bash

SRC=sysklogd-1.4.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://shlrm.org/sourcemage/$SRC
