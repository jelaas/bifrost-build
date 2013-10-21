#!/bin/bash

SRC=avr-libc-1.8.0.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/avr-libc/$SRC
