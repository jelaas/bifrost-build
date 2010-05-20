#!/bin/bash

SRC=console-data-1999.08.29.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://metalab.unc.edu/pub/Linux/system/keyboards/$SRC
