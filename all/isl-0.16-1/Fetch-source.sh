#!/bin/bash

SRC=isl-0.16.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://isl.gforge.inria.fr/$SRC
