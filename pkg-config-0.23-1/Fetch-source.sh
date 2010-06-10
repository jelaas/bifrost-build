#!/bin/bash

SRC=pkg-config-0.23.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkg-config.freedesktop.org/releases/$SRC
