#!/bin/bash

SRC=libssh2-1.3.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.libssh2.org/download/$SRC
