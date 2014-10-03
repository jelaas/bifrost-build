#!/bin/bash

SRC=l2tpns-2.1.21.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/l2tpns/l2tpns/2.1.21/$SRC

