#!/bin/bash

SRC=automake-1.14.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/automake/$SRC
