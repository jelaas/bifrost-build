#!/bin/bash

SRC=nmap-6.01.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST  http://nmap.org/dist/$SRC
