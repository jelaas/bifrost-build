#!/bin/bash

SRC=libvpx-v1.3.0.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://webm.googlecode.com/files/$SRC
