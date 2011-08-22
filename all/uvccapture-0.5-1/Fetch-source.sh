#!/bin/bash

SRC=uvccapture-0.5.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://staticwave.ca/source/uvccapture/$SRC
