#!/bin/bash

SRC=diffutils-3.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/diffutils/$SRC
