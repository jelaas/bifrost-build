#!/bin/bash

SRC=sed-4.2.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/sed/$SRC
