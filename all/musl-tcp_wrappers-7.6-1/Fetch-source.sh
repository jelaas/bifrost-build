#!/bin/bash

SRC=tcp_wrappers_7.6.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.porcupine.org/pub/security/$SRC
