#!/bin/bash

SRC=libogg-1.3.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.xiph.org/releases/ogg/$SRC
