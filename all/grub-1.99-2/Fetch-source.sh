#!/bin/bash

SRC=grub-1.99.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/grub/$SRC
