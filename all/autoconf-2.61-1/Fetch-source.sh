#!/bin/bash

SRC=autoconf-2.61.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/autoconf/$SRC
