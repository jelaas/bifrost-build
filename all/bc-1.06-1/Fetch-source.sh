#!/bin/bash

SRC=bc-1.06.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/bc/$SRC
