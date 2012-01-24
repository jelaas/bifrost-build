#!/bin/bash

SRC=tcllib-1.13.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/tcllib/tcllib/1.13/$SRC
