#!/bin/bash

SRC=pmacct-0.14.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.pmacct.net/$SRC
