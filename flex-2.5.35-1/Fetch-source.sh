#!/bin/bash

SRC=flex-2.5.35.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://switch.dl.sourceforge.net/project/flex/flex/flex-2.5.35/$SRC
