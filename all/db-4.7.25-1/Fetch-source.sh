#!/bin/bash

SRC=db-4.7.25.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://download.oracle.com/berkeley-db/$SRC
