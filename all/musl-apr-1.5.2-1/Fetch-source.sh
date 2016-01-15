#!/bin/bash

SRC=apr-1.5.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://archive.apache.org/dist/apr/$SRC
