#!/bin/bash

SRC=gettext-0.18.1.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gettext/$SRC
