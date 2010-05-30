#!/bin/bash

SRC=wget-1.12.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/wget/$SRC
