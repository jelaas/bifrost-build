#!/bin/bash

SRC=powertop-1.11.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://lesswatts.org/projects/powertop/download/powertop-1.11.tar.gz
