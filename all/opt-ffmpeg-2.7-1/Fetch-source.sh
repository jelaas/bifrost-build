#!/bin/bash

SRC=ffmpeg-2.7.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.ffmpeg.org/releases/$SRC
