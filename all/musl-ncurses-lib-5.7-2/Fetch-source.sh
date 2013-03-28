#!/bin/bash

SRC=ncurses-5.7.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/ncurses/$SRC
