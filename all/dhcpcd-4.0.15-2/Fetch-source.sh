#!/bin/bash

SRC=dhcpcd-4.0.15.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://roy.marples.name/downloads/dhcpcd/$SRC
