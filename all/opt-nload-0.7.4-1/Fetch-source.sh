#!/bin/bash

SRC=nload-0.7.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.roland-riegel.de/nload/$SRC
