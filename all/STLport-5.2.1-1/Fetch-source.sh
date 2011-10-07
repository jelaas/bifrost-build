#!/bin/bash

SRC=STLport-5.2.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/stlport/STLport/STLport-5.2.1/$SRC
