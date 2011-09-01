#!/bin/bash

SRC=mlmmj-1.2.17.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://mlmmj.org/releases/$SRC
