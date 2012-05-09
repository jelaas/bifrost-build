#!/bin/bash

SRC=libdnet-1.12.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://libdnet.googlecode.com/files/$SRC
