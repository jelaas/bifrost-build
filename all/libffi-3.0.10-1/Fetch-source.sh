#!/bin/bash

SRC=libffi-3.0.10.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://sourceware.org/pub/libffi/$SRC
