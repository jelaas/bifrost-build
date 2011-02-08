#!/bin/bash

SRC=lmbench2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.bitmover.com/lmbench/$SRC
