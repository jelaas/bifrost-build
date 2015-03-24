#!/bin/bash

SRC=alpine-2.11.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://patches.freeiz.com/alpine/release/src/$SRC
