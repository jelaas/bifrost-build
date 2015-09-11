#!/bin/bash

SRC=pwgen-2.07.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/pwgen/pwgen/2.07/$SRC
