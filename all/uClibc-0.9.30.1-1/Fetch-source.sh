#!/bin/bash

SRC=uClibc-0.9.30.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://uclibc.org/downloads/$SRC
