#!/bin/bash

SRC=bandwidth-0.23a.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://home.comcast.net/~fbui/$SRC
