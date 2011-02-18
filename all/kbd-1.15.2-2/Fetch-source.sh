#!/bin/bash

SRC=kbd-1.15.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.altlinux.org/pub/people/legion/kbd/$SRC
