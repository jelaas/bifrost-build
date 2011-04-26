#!/bin/bash

SRC=gpsd-2.95.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://download.berlios.de/gpsd/$SRC
