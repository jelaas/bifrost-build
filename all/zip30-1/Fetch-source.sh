#!/bin/bash

SRC=zip30.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.info-zip.org/pub/infozip/src/$SRC
