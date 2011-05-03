#!/bin/bash

SRC=zile-2.3.14.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/zile/$SRC
