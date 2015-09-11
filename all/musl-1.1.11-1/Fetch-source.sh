#!/bin/bash

SRC=musl-1.1.11.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.musl-libc.org/releases/$SRC
