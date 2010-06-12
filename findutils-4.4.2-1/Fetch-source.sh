#!/bin/bash

SRC=findutils-4.4.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/findutils/$SRC
