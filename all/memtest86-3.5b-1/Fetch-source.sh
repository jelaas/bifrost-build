#!/bin/bash

SRC=memtest86-3.5b.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://memtest86.com/$SRC
