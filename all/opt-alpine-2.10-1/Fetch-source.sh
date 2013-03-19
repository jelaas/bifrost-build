#!/bin/bash

SRC=alpine-2.10.clean.tar.lzma
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://patches.freeiz.com/alpine/patches/alpine-2.10/$SRC
