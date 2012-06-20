#!/bin/bash

SRC=bird-1.3.7.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://bird.network.cz/pub/bird/$SRC
