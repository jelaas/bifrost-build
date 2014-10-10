#!/bin/bash

SRC=m4-1.4.17.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/m4/$SRC
