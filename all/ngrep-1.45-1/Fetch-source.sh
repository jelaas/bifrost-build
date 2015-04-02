#!/bin/bash

SRC=ngrep-1.45.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/ngrep/ngrep/1.45/$SRC
