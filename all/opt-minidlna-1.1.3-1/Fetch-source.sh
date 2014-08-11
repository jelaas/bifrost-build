#!/bin/bash

SRC=minidlna-1.1.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/minidlna/minidlna/1.1.3/$SRC
