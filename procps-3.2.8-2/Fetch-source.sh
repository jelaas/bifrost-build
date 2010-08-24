#!/bin/bash

SRC=procps-3.2.8.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://procps.sourceforge.net/$SRC
