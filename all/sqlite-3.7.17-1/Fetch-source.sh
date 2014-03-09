#!/bin/bash

SRC=sqlite-3.7.17.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.sqlite.org/2013/sqlite-autoconf-3071700.tar.gz
