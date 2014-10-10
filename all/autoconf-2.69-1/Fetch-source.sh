#!/bin/bash

SRC=autoconf-2.69.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/autoconf/$SRC
