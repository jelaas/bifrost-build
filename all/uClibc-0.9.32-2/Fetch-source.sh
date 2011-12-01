#!/bin/bash

SRC=uClibc-0.9.32.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://uclibc.org/downloads/$SRC
