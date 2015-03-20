#!/bin/bash

SRC=curl-7.37.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://curl.haxx.se/download/$SRC
