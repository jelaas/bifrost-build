#!/bin/bash

SRC=expat-2.0.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://heanet.dl.sourceforge.net/project/expat/expat/2.0.1/$SRC
