#!/bin/bash

SRC=automake-1.11.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/automake/$SRC
