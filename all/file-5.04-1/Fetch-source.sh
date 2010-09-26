#!/bin/bash

SRC=file-5.04.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.astron.com/pub/file/$SRC
