#!/bin/bash

SRC=tclreadline-2.1.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/tclreadline/tclreadline/tclreadline-2.1.0/$SRC
