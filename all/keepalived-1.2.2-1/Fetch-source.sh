#!/bin/bash

SRC=keepalived-1.2.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.keepalived.org/software/$SRC
