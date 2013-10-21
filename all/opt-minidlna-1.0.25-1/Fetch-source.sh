#!/bin/bash

SRC=minidlna_1.0.25_src.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/minidlna/minidlna/1.0.25/$SRC