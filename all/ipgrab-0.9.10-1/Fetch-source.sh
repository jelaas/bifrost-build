#!/bin/bash

SRC=ipgrab-0.9.10.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/ipgrab/ipgrab/0.9.10/$SRC
