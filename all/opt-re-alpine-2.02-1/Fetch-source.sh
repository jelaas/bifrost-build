#!/bin/bash

SRC=re-alpine-2.02.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://osdn.dl.sourceforge.net/sourceforge/re-alpine/$SRC
