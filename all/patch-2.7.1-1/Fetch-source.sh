#!/bin/bash

SRC=patch-2.7.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/patch/$SRC
