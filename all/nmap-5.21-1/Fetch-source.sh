#!/bin/bash

SRC=nmap-5.21.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST  http://nmap.org/dist/$SRC
