#!/bin/bash

SRC=xz-5.0.3.tar.bz2 
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://tukaani.org/xz/$SRC
