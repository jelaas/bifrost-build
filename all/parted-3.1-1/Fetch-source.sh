#!/bin/bash

SRC=parted-3.1.tar.xz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/parted/$SRC
