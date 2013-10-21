#!/bin/bash

SRC=lame-3.99.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/lame/lame/3.99/$SRC
