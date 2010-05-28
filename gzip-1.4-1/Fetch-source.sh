#!/bin/bash

SRC=gzip-1.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gzip/$SRC
