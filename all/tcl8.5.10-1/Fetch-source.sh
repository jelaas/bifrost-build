#!/bin/bash

SRC=tcl8.5.10-src.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://prdownloads.sourceforge.net/tcl/$SRC
