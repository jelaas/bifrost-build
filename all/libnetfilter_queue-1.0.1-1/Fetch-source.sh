#!/bin/bash

SRC=libnetfilter_queue-1.0.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnetfilter_queue/files/$SRC
