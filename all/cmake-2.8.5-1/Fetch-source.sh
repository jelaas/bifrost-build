#!/bin/bash

SRC=cmake-2.8.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.cmake.org/files/v2.8/$SRC
