#!/bin/bash

SRC=binutils-2.23.tar.gz  
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz
