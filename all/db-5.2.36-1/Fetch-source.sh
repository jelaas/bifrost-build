#!/bin/bash

SRC=db-5.2.36.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://download.oracle.com/berkeley-db/$SRC
