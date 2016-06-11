#!/bin/bash

SRC=iproute2-2.6.34.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/iproute/iproute2-2.6.34.tar.bz2/5c5742bdac05a1688f266512e685b83c/$SRC
