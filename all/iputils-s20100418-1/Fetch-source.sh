#!/bin/bash

SRC=iputils-s20100418.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.skbuff.net/iputils/$SRC
