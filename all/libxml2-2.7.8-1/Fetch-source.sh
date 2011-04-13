#!/bin/bash

SRC=libxml2-2.7.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://xmlsoft.org/libxml2/$SRC
