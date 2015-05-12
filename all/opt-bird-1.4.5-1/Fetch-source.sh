#!/bin/bash

SRC=bird-1.4.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://bird.network.cz/pub/bird/$SRC
