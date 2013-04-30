#!/bin/bash

SRC=libvorbis-1.3.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.xiph.org/releases/vorbis/$SRC
