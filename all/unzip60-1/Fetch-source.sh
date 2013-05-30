#!/bin/bash

SRC=unzip60.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.info-zip.org/pub/infozip/src/$SRC
