#!/bin/bash

SRC=net-tools-1.60.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.tazenda.demon.co.uk/phil/net-tools/$SRC
