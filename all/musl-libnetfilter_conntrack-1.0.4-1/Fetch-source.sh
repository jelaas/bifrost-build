#!/bin/bash

SRC=libnetfilter_conntrack-1.0.4.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnetfilter_conntrack/files/$SRC
