#!/bin/bash

SRC=nasm-2.08.02.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.nasm.us/pub/nasm/releasebuilds/2.08.02/$SRC
