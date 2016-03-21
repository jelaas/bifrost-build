#!/bin/bash

SRC=memtest86-3.5b.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC
