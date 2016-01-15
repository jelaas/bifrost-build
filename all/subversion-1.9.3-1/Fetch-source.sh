#!/bin/bash

SRC=subversion-1.9.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://apache.mirrors.spacedump.net/subversion/$SRC
