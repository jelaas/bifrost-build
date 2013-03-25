#!/bin/bash

SRC=libexif-0.6.21.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/libexif/libexif/0.6.21/$SRC
