#!/bin/bash

SRC=sqlite-autoconf-3071602.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.sqlite.org/2013/$SRC
