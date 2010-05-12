#!/bin/bash

SRC=curl-7.20.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://curl.haxx.se/download/$SRC
