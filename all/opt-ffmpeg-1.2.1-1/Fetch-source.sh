#!/bin/bash

SRC=ffmpeg-1.2.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=5071a26cc149f380908ce79ec2a677ef

[ -s "$DST" ] || wget -O $DST http://www.ffmpeg.org/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
