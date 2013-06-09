#!/bin/bash

SRC=ffmpeg-1.2.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.ffmpeg.org/releases/$SRC
