#!/bin/bash

SRC=flac-1.2.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/flac/flac-src/flac-1.2.1-src/$SRC
