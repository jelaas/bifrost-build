#!/bin/bash

SRC=libav-9.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.libav.org/releases/$SRC
