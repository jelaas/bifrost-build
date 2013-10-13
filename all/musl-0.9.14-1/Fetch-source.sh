#!/bin/bash

SRC=musl-0.9.14.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC
