#!/bin/bash

SRC=ffmpeg-2.7.tar.bz2
DST=/var/spool/src/$SRC
MD5=5a16425b0bde1b952f58cff71b569a45

[ -s "$DST" ] || wget -O $DST http://www.ffmpeg.org/releases/$SRC || \
    ../../wget-finder -O $DST $SRC:$MD5
