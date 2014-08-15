#!/bin/bash

SRC=strace-4.5.20.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/strace/strace/4.5.20/$SRC
