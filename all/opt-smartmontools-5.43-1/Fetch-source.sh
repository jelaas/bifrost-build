#!/bin/bash

SRC=smartmontools-5.43.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/smartmontools/smartmontools/5.43/$SRC
