#!/bin/bash

SRC=gawk-3.1.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gawk/$SRC
