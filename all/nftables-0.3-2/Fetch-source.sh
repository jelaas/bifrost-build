#!/bin/bash

SRC=nftables-0.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.netfilter.org/pub/nftables/$SRC
