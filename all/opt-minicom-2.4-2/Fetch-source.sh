#!/bin/bash

SRC=minicom-2.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://alioth.debian.org/download.php/3195/$SRC
