#!/bin/bash

SRC=musl-0.9.10.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC
