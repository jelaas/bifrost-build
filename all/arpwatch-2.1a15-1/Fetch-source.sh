#!/bin/bash

SRC=arpwatch.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.ee.lbl.gov/$SRC

