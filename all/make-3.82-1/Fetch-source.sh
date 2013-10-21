#!/bin/bash

SRC=make-3.82.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/make/make-3.82.tar.gz
