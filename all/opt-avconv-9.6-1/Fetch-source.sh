#!/bin/bash

SRC=libav-9.6.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://libav.org/releases/$SRC
