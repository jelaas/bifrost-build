#!/bin/bash

SRC=gdb-6.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/gdb/gdb-6.3a.tar.bz2
