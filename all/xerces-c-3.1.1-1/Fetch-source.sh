#!/bin/bash

SRC=xerces-c-3.1.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/xerces/c/3/sources/$SRC

