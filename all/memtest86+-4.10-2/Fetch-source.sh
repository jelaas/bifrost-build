#!/bin/bash

SRC=memtest86+-4.10.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.memtest.org/download/4.10/$SRC
