#!/bin/bash

SRC=libevent-1.4.13-stable.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.monkey.org/~provos/$SRC
