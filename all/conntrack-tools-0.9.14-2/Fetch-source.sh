#!/bin/bash

SRC=conntrack-tools-0.9.14.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/conntrack-tools/files/$SRC
